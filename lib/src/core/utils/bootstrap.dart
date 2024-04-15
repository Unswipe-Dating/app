import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_network.dart';
import '../router/app_router.dart';
import 'app_bloc_observer.dart';
import 'injections.dart';
import 'log/app_logger.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder, String env) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      CustomNavigationHelper.instance;

      flutterLogError();
      usePathUrlStrategy();
      HttpOverrides.global = MyHttpOverrides();
      configureAppInjection(Environment.dev);
      initDioInjections();
      Bloc.observer = AppBlocObserver();
      runApp(
          await builder()
      );
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

Future<void> initDioInjections() async {
  // initRootLogger();
  // DioNetwork.initDio();
}

void flutterLogError() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
