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
    as _i8;
import '../../features/login/data/repository/login_repository_impl.dart'
    as _i29;
import '../../features/login/domain/repository/login_repository.dart' as _i28;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i44;
import '../../features/login/domain/usecases/signup_login_usecase.dart' as _i45;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i41;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i46;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i47;
import '../../features/onBoarding/domain/usecases/reset_user_token_state_stream_usecase.dart'
    as _i48;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i49;
import '../../features/settings/data/datasources/remote/UserSettingService.dart'
    as _i9;
import '../../features/settings/data/repository/user_settings_repository_impl.dart'
    as _i31;
import '../../features/settings/domain/repository/user_settings_repository.dart'
    as _i30;
import '../../features/settings/domain/usecases/get_settings_profile_usecase.dart'
    as _i38;
import '../../features/splash/data/datasources/remote/meta_api_service.dart'
    as _i10;
import '../../features/splash/data/repository/splash_repository_impl.dart'
    as _i16;
import '../../features/splash/domain/repository/splash_repository.dart' as _i15;
import '../../features/splash/domain/usecases/meta_usecase.dart' as _i20;
import '../../features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart'
    as _i11;
import '../../features/userOnboarding/contact_block/data/repository/contact_block_repository_impl.dart'
    as _i26;
import '../../features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart'
    as _i25;
import '../../features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart'
    as _i43;
import '../../features/userOnboarding/image_upload/data/datasources/network/image_upload_service.dart'
    as _i12;
import '../../features/userOnboarding/image_upload/data/repository/image_upload_repository_impl.dart'
    as _i22;
import '../../features/userOnboarding/image_upload/domain/repository/image_upload_repository.dart'
    as _i21;
import '../../features/userOnboarding/image_upload/domain/usecase/image_upload_usecase.dart'
    as _i27;
import '../../features/userOnboarding/profile_update/data/datasources/network/service/profile_update_service.dart'
    as _i13;
import '../../features/userOnboarding/profile_update/data/repository/update_profile_repository_impl.dart'
    as _i24;
import '../../features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart'
    as _i23;
import '../../features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart'
    as _i50;
import '../../features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart'
    as _i51;
import '../../features/userProfile/data/datasources/network/profile_swipe_service.dart'
    as _i14;
import '../../features/userProfile/data/repository/profile_swipe_repository_impl.dart'
    as _i19;
import '../../features/userProfile/domain/repository/profile_swipe_repository.dart'
    as _i18;
import '../../features/userProfile/domain/usecase/profile_accept_usecase.dart'
    as _i32;
import '../../features/userProfile/domain/usecase/profile_create_usecase.dart'
    as _i33;
import '../../features/userProfile/domain/usecase/profile_get_requested_usecase.dart'
    as _i34;
import '../../features/userProfile/domain/usecase/profile_get_usecase.dart'
    as _i35;
import '../../features/userProfile/domain/usecase/profile_reject_usecase.dart'
    as _i36;
import '../../features/userProfile/domain/usecase/profile_skip_usecase.dart'
    as _i37;
import '../../shared/data/repository/user_repository_imp.dart' as _i40;
import '../../shared/domain/repository/user_repository.dart' as _i39;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i42;
import '../local_data_source.dart' as _i5;
import '../network/graphql/graphql_service.dart' as _i4;
import '../network/graphql/RequestTokenService.dart' as _i7;
import '../shared_pref_util.dart' as _i17;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i52;

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
    gh.factory<_i7.RequestTokenService>(
        () => _i7.RequestTokenService(gh<_i4.GraphQLService>()));
    gh.factory<_i8.OtpService>(() => _i8.OtpService(gh<_i4.GraphQLService>()));
    gh.factory<_i9.UserSettingService>(
        () => _i9.UserSettingService(gh<_i4.GraphQLService>()));
    gh.factory<_i10.MetaService>(
        () => _i10.MetaService(gh<_i4.GraphQLService>()));
    gh.factory<_i11.ContactBlockService>(
        () => _i11.ContactBlockService(gh<_i4.GraphQLService>()));
    gh.factory<_i12.ImageUploadService>(
        () => _i12.ImageUploadService(gh<_i4.GraphQLService>()));
    gh.factory<_i13.UpdateUserService>(
        () => _i13.UpdateUserService(gh<_i4.GraphQLService>()));
    gh.factory<_i14.ProfileSwipeService>(
        () => _i14.ProfileSwipeService(gh<_i4.GraphQLService>()));
    gh.factory<_i15.SplashRepository>(
        () => _i16.SplashRepositoryImpl(gh<_i10.MetaService>()));
    gh.factory<_i5.LocalDataSource>(() => _i17.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i18.ProfileSwipeRepository>(
        () => _i19.ProfileSwipeRepositoryImpl(gh<_i14.ProfileSwipeService>()));
    gh.factory<_i20.MetaUseCase>(
        () => _i20.MetaUseCase(gh<_i15.SplashRepository>()));
    gh.factory<_i21.ImageUploadRepository>(
        () => _i22.ImageUploadRepositoryImpl(gh<_i12.ImageUploadService>()));
    gh.factory<_i23.UpdateProfileRepository>(
        () => _i24.UpdateProfileRepositoryImpl(gh<_i13.UpdateUserService>()));
    gh.factory<_i25.ContactBlockRepository>(
        () => _i26.ContactBlockRepositoryImpl(gh<_i11.ContactBlockService>()));
    gh.factory<_i27.ImageUploadUseCase>(
        () => _i27.ImageUploadUseCase(gh<_i21.ImageUploadRepository>()));
    gh.factory<_i28.LoginRepository>(
        () => _i29.LoginRepositoryImpl(gh<_i8.OtpService>()));
    gh.factory<_i30.UserSettingsRepository>(
        () => _i31.UserSettingsRepositoryImpl(gh<_i9.UserSettingService>()));
    gh.factory<_i32.ProfileAcceptUseCase>(
        () => _i32.ProfileAcceptUseCase(gh<_i18.ProfileSwipeRepository>()));
    gh.factory<_i33.ProfileCreateUseCase>(
        () => _i33.ProfileCreateUseCase(gh<_i18.ProfileSwipeRepository>()));
    gh.factory<_i34.ProfileGetRequestedUseCase>(() =>
        _i34.ProfileGetRequestedUseCase(gh<_i18.ProfileSwipeRepository>()));
    gh.factory<_i35.ProfileGetUseCase>(
        () => _i35.ProfileGetUseCase(gh<_i18.ProfileSwipeRepository>()));
    gh.factory<_i36.ProfileRejectUseCase>(
        () => _i36.ProfileRejectUseCase(gh<_i18.ProfileSwipeRepository>()));
    gh.factory<_i37.ProfileSkipUseCase>(
        () => _i37.ProfileSkipUseCase(gh<_i18.ProfileSwipeRepository>()));
    gh.factory<_i38.GetSettingsProfileUseCase>(() =>
        _i38.GetSettingsProfileUseCase(gh<_i30.UserSettingsRepository>()));
    gh.factory<_i39.UserRepository>(
        () => _i40.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i41.UpdateUserStateStreamUseCase>(
        () => _i41.UpdateUserStateStreamUseCase(gh<_i39.UserRepository>()));
    gh.factory<_i42.GetAuthStateStreamUseCase>(
        () => _i42.GetAuthStateStreamUseCase(gh<_i39.UserRepository>()));
    gh.factory<_i43.ContactBlockUseCase>(
        () => _i43.ContactBlockUseCase(gh<_i25.ContactBlockRepository>()));
    gh.factory<_i44.RequestOtpUseCase>(
        () => _i44.RequestOtpUseCase(gh<_i28.LoginRepository>()));
    gh.factory<_i45.SignUpUseCase>(
        () => _i45.SignUpUseCase(gh<_i28.LoginRepository>()));
    gh.factory<_i46.VerifyOtpUseCase>(
        () => _i46.VerifyOtpUseCase(gh<_i28.LoginRepository>()));
    gh.factory<_i47.GetOnboardingStateStreamUseCase>(
        () => _i47.GetOnboardingStateStreamUseCase(gh<_i39.UserRepository>()));
    gh.factory<_i48.ResetUserTokenStateStreamUseCase>(
        () => _i48.ResetUserTokenStateStreamUseCase(gh<_i39.UserRepository>()));
    gh.factory<_i49.UpdateOnboardingStateStreamUseCase>(() =>
        _i49.UpdateOnboardingStateStreamUseCase(gh<_i39.UserRepository>()));
    gh.factory<_i50.CreateProfileUseCase>(
        () => _i50.CreateProfileUseCase(gh<_i23.UpdateProfileRepository>()));
    gh.factory<_i51.UpdateProfileUseCase>(
        () => _i51.UpdateProfileUseCase(gh<_i23.UpdateProfileRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i52.RegisterModule {}
