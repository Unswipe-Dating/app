import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:unswipe/src/core/local_data_source.dart';
import 'package:unswipe/src/core/shared_pref_util.dart';
import 'package:unswipe/src/core/utils/constant/method_channel_crypto_impl.dart';
import 'package:unswipe/src/shared/data/repository/user_repository_imp.dart';
import 'package:unswipe/src/shared/domain/repository/user_repository.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/get_onboarding_state_stream_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../core/utils/injections.dart';
import 'data/data_sources/app_shared_prefs.dart';

initAppInjections() {
  //todo: update to singletons
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));

  sl.registerFactory<LocalDataSource>(() => SharedPrefUtil(RxSharedPreferences.getInstance(), MethodChannelCryptoImpl()));

  sl.registerFactory<UserRepository>(() => UserRepositoryImpl(sl<LocalDataSource>()));

  sl.registerFactory<GetAuthStateStreamUseCase>(() => GetAuthStateStreamUseCase(sl<UserRepository>()));

  sl.registerFactory<UpdateOnboardingStateStreamUseCase>(() => UpdateOnboardingStateStreamUseCase(sl<UserRepository>()));


  sl.registerFactory<GetOnboardingStateStreamUseCase>(() => GetOnboardingStateStreamUseCase(sl<UserRepository>()));

}
