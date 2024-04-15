import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unswipe/src/core/utils/injections.config.dart';

import '../../features/splash/splash_injections.dart';
import '../../shared/app_injections.dart';
import '../network/dio_network.dart';
import 'log/app_logger.dart';


@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureAppInjection(String env) {
  GetIt.instance.$initGetIt(environment: env);
}

