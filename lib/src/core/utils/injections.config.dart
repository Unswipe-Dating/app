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

import '../../features/login/data/datasources/network/service/otp_service.dart'
    as _i7;
import '../../features/login/data/repository/login_repository_impl.dart'
    as _i15;
import '../../features/login/domain/repository/login_repository.dart' as _i14;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i16;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i20;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i17;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i22;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i23;
import '../../features/userOnboarding/contact_block/data/datasources/network/service/user_onboarding_service.dart'
    as _i8;
import '../../features/userOnboarding/contact_block/data/repository/on_boarding_user_repository_impl.dart'
    as _i11;
import '../../features/userOnboarding/contact_block/domain/repository/on_boarding_user_repository.dart'
    as _i10;
import '../../features/userOnboarding/contact_block/domain/usecases/block_contact_usecase.dart'
    as _i12;
import '../../features/userOnboarding/contact_block/domain/usecases/upload_images_use_case.dart'
    as _i13;
import '../../shared/data/repository/user_repository_imp.dart' as _i19;
import '../../shared/domain/repository/user_repository.dart' as _i18;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i21;
import '../local_data_source.dart' as _i5;
import '../network/graphql/graphql_service.dart' as _i4;
import '../shared_pref_util.dart' as _i9;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i24;

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
    gh.factory<_i8.UserOnboardingService>(
        () => _i8.UserOnboardingService(gh<_i4.GraphQLService>()));
    gh.factory<_i5.LocalDataSource>(() => _i9.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i10.UserOnboardingRepository>(() =>
        _i11.UserOnboardingRepositoryImpl(gh<_i8.UserOnboardingService>()));
    gh.factory<_i12.BlockContactUseCase>(
        () => _i12.BlockContactUseCase(gh<_i10.UserOnboardingRepository>()));
    gh.factory<_i13.UploadImageUseCase>(
        () => _i13.UploadImageUseCase(gh<_i10.UserOnboardingRepository>()));
    gh.factory<_i14.LoginRepository>(
        () => _i15.LoginRepositoryImpl(gh<_i7.OtpService>()));
    gh.factory<_i16.RequestOtpUseCase>(
        () => _i16.RequestOtpUseCase(gh<_i14.LoginRepository>()));
    gh.factory<_i17.VerifyOtpUseCase>(
        () => _i17.VerifyOtpUseCase(gh<_i14.LoginRepository>()));
    gh.factory<_i18.UserRepository>(
        () => _i19.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i20.UpdateUserStateStreamUseCase>(
        () => _i20.UpdateUserStateStreamUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i21.GetAuthStateStreamUseCase>(
        () => _i21.GetAuthStateStreamUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i22.GetOnboardingStateStreamUseCase>(
        () => _i22.GetOnboardingStateStreamUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i23.UpdateOnboardingStateStreamUseCase>(() =>
        _i23.UpdateOnboardingStateStreamUseCase(gh<_i18.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i24.RegisterModule {}
