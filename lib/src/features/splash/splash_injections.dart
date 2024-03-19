
import 'package:unswipe/src/features/splash/data/datasources/local/splash_shared_pref.dart';
import 'package:unswipe/src/features/splash/data/repository/splash_repository_impl.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';
import 'package:unswipe/src/features/splash/domain/usecases/splash_usecase.dart';

import '../../core/utils/injections.dart';

initSplashInjections() {
  sl.registerSingleton<AbstractSplashRepository>(SplashRepositoryImpl());
  sl.registerSingleton<SplashSharedPref>(SplashSharedPref(sl()));
  sl.registerSingleton<SplashUseCase>(SplashUseCase(sl()));
}