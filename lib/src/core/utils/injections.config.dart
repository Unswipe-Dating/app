// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i3;

import '../../features/login/data/datasources/network/graphql/graphql_service.dart'
    as _i4;
import '../../features/login/data/datasources/network/service/otp_service.dart'
    as _i7;
import '../../features/login/data/repository/login_repository_impl.dart'
    as _i10;
import '../../features/login/domain/repository/login_repository.dart' as _i9;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i11;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i14;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i16;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i17;
import '../../shared/data/repository/user_repository_imp.dart' as _i13;
import '../../shared/domain/repository/user_repository.dart' as _i12;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i15;
import '../local_data_source.dart' as _i5;
import '../shared_pref_util.dart' as _i8;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i18;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt $initGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factoryAsync<_i3.SharedPreferences>(() => registerModule.prefs);
    gh.factory<_i3.RxSharedPreferences>(() => registerModule.rxPrefs);
    gh.singleton<_i4.GraphQLService>(() => _i4.GraphQLService());
    gh.factory<_i5.Crypto>(() => _i6.MethodChannelCryptoImpl());
    gh.factory<_i7.OtpService>(() => _i7.OtpService(gh<_i4.GraphQLService>()));
    gh.factory<_i5.LocalDataSource>(() => _i8.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i9.LoginRepository>(
        () => _i10.LoginRepositoryImpl(gh<_i7.OtpService>()));
    gh.factory<_i11.RequestOtpUseCase>(
        () => _i11.RequestOtpUseCase(gh<_i9.LoginRepository>()));
    gh.factory<_i12.UserRepository>(
        () => _i13.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i14.UpdateUserStateStreamUseCase>(
        () => _i14.UpdateUserStateStreamUseCase(gh<_i12.UserRepository>()));
    gh.factory<_i15.GetAuthStateStreamUseCase>(
        () => _i15.GetAuthStateStreamUseCase(gh<_i12.UserRepository>()));
    gh.factory<_i16.GetOnboardingStateStreamUseCase>(
        () => _i16.GetOnboardingStateStreamUseCase(gh<_i12.UserRepository>()));
    gh.factory<_i17.UpdateOnboardingStateStreamUseCase>(() =>
        _i17.UpdateOnboardingStateStreamUseCase(gh<_i12.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}
