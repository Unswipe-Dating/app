import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:unswipe/src/core/utils/bootstrap.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/core/router/app_router.dart';
import 'package:unswipe/src/core/styles/app_theme.dart';
import 'package:unswipe/src/core/translations/l10n.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unswipe/src/core/helper/helper.dart';
import 'package:unswipe/src/core/utils/injections.dart';
import 'package:unswipe/src/shared/data/data_sources/app_shared_prefs.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await bootstrap(() =>  const App(), Environment.dev);

}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale locale = const Locale("en");
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /** Change Notifier helps with chaging everything on language change*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppNotifier(),
      child: Consumer<AppNotifier>(
        builder: (context, value, child) {
              return MaterialApp.router(
                routerConfig: CustomNavigationHelper.router,
                scaffoldMessengerKey: snackBarKey,
                theme: appTheme,
                debugShowCheckedModeBanner: false,
                locale: locale,
                builder: DevicePreview.appBuilder,
              );
        },
      ),
    );
  }
}

// App notifier for Lang, Theme, ...
class AppNotifier extends ChangeNotifier {
  late bool darkTheme;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    darkTheme = await Helper.isDarkTheme();

    notifyListeners();
  }

}
