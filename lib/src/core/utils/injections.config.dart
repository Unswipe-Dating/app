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
    as _i28;
import '../../features/login/domain/repository/login_repository.dart' as _i27;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i43;
import '../../features/login/domain/usecases/signup_login_usecase.dart' as _i44;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i40;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i45;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i46;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i47;
import '../../features/settings/data/datasources/remote/UserSettingService.dart'
    as _i13;
import '../../features/settings/data/repository/user_settings_repository_impl.dart'
    as _i30;
import '../../features/settings/domain/repository/user_settings_repository.dart'
    as _i29;
import '../../features/settings/domain/usecases/get_settings_profile_usecase.dart'
    as _i37;
import '../../features/splash/data/datasources/remote/meta_api_service.dart'
    as _i8;
import '../../features/splash/data/repository/splash_repository_impl.dart'
    as _i15;
import '../../features/splash/domain/repository/splash_repository.dart' as _i14;
import '../../features/splash/domain/usecases/meta_usecase.dart' as _i19;
import '../../features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart'
    as _i9;
import '../../features/userOnboarding/contact_block/data/repository/contact_block_repository_impl.dart'
    as _i25;
import '../../features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart'
    as _i24;
import '../../features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart'
    as _i42;
import '../../features/userOnboarding/image_upload/data/datasources/network/image_upload_service.dart'
    as _i10;
import '../../features/userOnboarding/image_upload/data/repository/image_upload_repository_impl.dart'
    as _i21;
import '../../features/userOnboarding/image_upload/domain/repository/image_upload_repository.dart'
    as _i20;
import '../../features/userOnboarding/image_upload/domain/usecase/image_upload_usecase.dart'
    as _i26;
import '../../features/userOnboarding/profile_update/data/datasources/network/service/profile_update_service.dart'
    as _i11;
import '../../features/userOnboarding/profile_update/data/repository/update_profile_repository_impl.dart'
    as _i23;
import '../../features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart'
    as _i22;
import '../../features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart'
    as _i48;
import '../../features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart'
    as _i49;
import '../../features/userProfile/data/datasources/network/profile_swipe_service.dart'
    as _i12;
import '../../features/userProfile/data/repository/profile_swipe_repository_impl.dart'
    as _i18;
import '../../features/userProfile/domain/repository/profile_swipe_repository.dart'
    as _i17;
import '../../features/userProfile/domain/usecase/profile_accept_usecase.dart'
    as _i31;
import '../../features/userProfile/domain/usecase/profile_create_usecase.dart'
    as _i32;
import '../../features/userProfile/domain/usecase/profile_get_requested_usecase.dart'
    as _i33;
import '../../features/userProfile/domain/usecase/profile_get_usecase.dart'
    as _i34;
import '../../features/userProfile/domain/usecase/profile_reject_usecase.dart'
    as _i35;
import '../../features/userProfile/domain/usecase/profile_skip_usecase.dart'
    as _i36;
import '../../shared/data/repository/user_repository_imp.dart' as _i39;
import '../../shared/domain/repository/user_repository.dart' as _i38;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i41;
import '../local_data_source.dart' as _i5;
import '../network/graphql/graphql_service.dart' as _i4;
import '../shared_pref_util.dart' as _i16;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i50;

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
    gh.factory<_i8.MetaService>(
        () => _i8.MetaService(gh<_i4.GraphQLService>()));
    gh.factory<_i9.ContactBlockService>(
        () => _i9.ContactBlockService(gh<_i4.GraphQLService>()));
    gh.factory<_i10.ImageUploadService>(
        () => _i10.ImageUploadService(gh<_i4.GraphQLService>()));
    gh.factory<_i11.UpdateUserService>(
        () => _i11.UpdateUserService(gh<_i4.GraphQLService>()));
    gh.factory<_i12.ProfileSwipeService>(
        () => _i12.ProfileSwipeService(gh<_i4.GraphQLService>()));
    gh.factory<_i13.UserSettingService>(
        () => _i13.UserSettingService(gh<_i4.GraphQLService>()));
    gh.factory<_i14.SplashRepository>(
        () => _i15.SplashRepositoryImpl(gh<_i8.MetaService>()));
    gh.factory<_i5.LocalDataSource>(() => _i16.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i17.ProfileSwipeRepository>(
        () => _i18.ProfileSwipeRepositoryImpl(gh<_i12.ProfileSwipeService>()));
    gh.factory<_i19.MetaUseCase>(
        () => _i19.MetaUseCase(gh<_i14.SplashRepository>()));
    gh.factory<_i20.ImageUploadRepository>(
        () => _i21.ImageUploadRepositoryImpl(gh<_i10.ImageUploadService>()));
    gh.factory<_i22.UpdateProfileRepository>(
        () => _i23.UpdateProfileRepositoryImpl(gh<_i11.UpdateUserService>()));
    gh.factory<_i24.ContactBlockRepository>(
        () => _i25.ContactBlockRepositoryImpl(gh<_i9.ContactBlockService>()));
    gh.factory<_i26.ImageUploadUseCase>(
        () => _i26.ImageUploadUseCase(gh<_i20.ImageUploadRepository>()));
    gh.factory<_i27.LoginRepository>(
        () => _i28.LoginRepositoryImpl(gh<_i7.OtpService>()));
    gh.factory<_i29.UserSettingsRepository>(
        () => _i30.UserSettingsRepositoryImpl(gh<_i13.UserSettingService>()));
    gh.factory<_i31.ProfileAcceptUseCase>(
        () => _i31.ProfileAcceptUseCase(gh<_i17.ProfileSwipeRepository>()));
    gh.factory<_i32.ProfileCreateUseCase>(
        () => _i32.ProfileCreateUseCase(gh<_i17.ProfileSwipeRepository>()));
    gh.factory<_i33.ProfileGetRequestedUseCase>(() =>
        _i33.ProfileGetRequestedUseCase(gh<_i17.ProfileSwipeRepository>()));
    gh.factory<_i34.ProfileGetUseCase>(
        () => _i34.ProfileGetUseCase(gh<_i17.ProfileSwipeRepository>()));
    gh.factory<_i35.ProfileRejectUseCase>(
        () => _i35.ProfileRejectUseCase(gh<_i17.ProfileSwipeRepository>()));
    gh.factory<_i36.ProfileSkipUseCase>(
        () => _i36.ProfileSkipUseCase(gh<_i17.ProfileSwipeRepository>()));
    gh.factory<_i37.GetSettingsProfileUseCase>(() =>
        _i37.GetSettingsProfileUseCase(gh<_i29.UserSettingsRepository>()));
    gh.factory<_i38.UserRepository>(
        () => _i39.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i40.UpdateUserStateStreamUseCase>(
        () => _i40.UpdateUserStateStreamUseCase(gh<_i38.UserRepository>()));
    gh.factory<_i41.GetAuthStateStreamUseCase>(
        () => _i41.GetAuthStateStreamUseCase(gh<_i38.UserRepository>()));
    gh.factory<_i42.ContactBlockUseCase>(
        () => _i42.ContactBlockUseCase(gh<_i24.ContactBlockRepository>()));
    gh.factory<_i43.RequestOtpUseCase>(
        () => _i43.RequestOtpUseCase(gh<_i27.LoginRepository>()));
    gh.factory<_i44.SignUpUseCase>(
        () => _i44.SignUpUseCase(gh<_i27.LoginRepository>()));
    gh.factory<_i45.VerifyOtpUseCase>(
        () => _i45.VerifyOtpUseCase(gh<_i27.LoginRepository>()));
    gh.factory<_i46.GetOnboardingStateStreamUseCase>(
        () => _i46.GetOnboardingStateStreamUseCase(gh<_i38.UserRepository>()));
    gh.factory<_i47.UpdateOnboardingStateStreamUseCase>(() =>
        _i47.UpdateOnboardingStateStreamUseCase(gh<_i38.UserRepository>()));
    gh.factory<_i48.CreateProfileUseCase>(
        () => _i48.CreateProfileUseCase(gh<_i22.UpdateProfileRepository>()));
    gh.factory<_i49.UpdateProfileUseCase>(
        () => _i49.UpdateProfileUseCase(gh<_i22.UpdateProfileRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i50.RegisterModule {}
