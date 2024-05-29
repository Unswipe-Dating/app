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
    as _i27;
import '../../features/login/domain/repository/login_repository.dart' as _i26;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i39;
import '../../features/login/domain/usecases/signup_login_usecase.dart' as _i40;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i36;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i41;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i42;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i43;
import '../../features/splash/data/datasources/remote/meta_api_service.dart'
    as _i8;
import '../../features/splash/data/repository/splash_repository_impl.dart'
    as _i14;
import '../../features/splash/domain/repository/splash_repository.dart' as _i13;
import '../../features/splash/domain/usecases/meta_usecase.dart' as _i18;
import '../../features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart'
    as _i9;
import '../../features/userOnboarding/contact_block/data/repository/contact_block_repository_impl.dart'
    as _i24;
import '../../features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart'
    as _i23;
import '../../features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart'
    as _i38;
import '../../features/userOnboarding/image_upload/data/datasources/network/image_upload_service.dart'
    as _i10;
import '../../features/userOnboarding/image_upload/data/repository/image_upload_repository_impl.dart'
    as _i20;
import '../../features/userOnboarding/image_upload/domain/repository/image_upload_repository.dart'
    as _i19;
import '../../features/userOnboarding/image_upload/domain/usecase/image_upload_usecase.dart'
    as _i25;
import '../../features/userOnboarding/profile_update/data/datasources/network/service/profile_update_service.dart'
    as _i11;
import '../../features/userOnboarding/profile_update/data/repository/update_profile_repository_impl.dart'
    as _i22;
import '../../features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart'
    as _i21;
import '../../features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart'
    as _i44;
import '../../features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart'
    as _i45;
import '../../features/userProfile/data/datasources/network/profile_swipe_service.dart'
    as _i12;
import '../../features/userProfile/data/repository/profile_swipe_repository_impl.dart'
    as _i17;
import '../../features/userProfile/domain/repository/profile_swipe_repository.dart'
    as _i16;
import '../../features/userProfile/domain/usecase/profile_accept_usecase.dart'
    as _i28;
import '../../features/userProfile/domain/usecase/profile_create_usecase.dart'
    as _i29;
import '../../features/userProfile/domain/usecase/profile_get_requested_usecase.dart'
    as _i30;
import '../../features/userProfile/domain/usecase/profile_get_usecase.dart'
    as _i31;
import '../../features/userProfile/domain/usecase/profile_reject_usecase.dart'
    as _i32;
import '../../features/userProfile/domain/usecase/profile_skip_usecase.dart'
    as _i33;
import '../../shared/data/repository/user_repository_imp.dart' as _i35;
import '../../shared/domain/repository/user_repository.dart' as _i34;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i37;
import '../local_data_source.dart' as _i5;
import '../network/graphql/graphql_service.dart' as _i4;
import '../shared_pref_util.dart' as _i15;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i46;

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
    gh.factory<_i13.SplashRepository>(
        () => _i14.SplashRepositoryImpl(gh<_i8.MetaService>()));
    gh.factory<_i5.LocalDataSource>(() => _i15.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i16.ProfileSwipeRepository>(
        () => _i17.ProfileSwipeRepositoryImpl(gh<_i12.ProfileSwipeService>()));
    gh.factory<_i18.MetaUseCase>(
        () => _i18.MetaUseCase(gh<_i13.SplashRepository>()));
    gh.factory<_i19.ImageUploadRepository>(
        () => _i20.ImageUploadRepositoryImpl(gh<_i10.ImageUploadService>()));
    gh.factory<_i21.UpdateProfileRepository>(
        () => _i22.UpdateProfileRepositoryImpl(gh<_i11.UpdateUserService>()));
    gh.factory<_i23.ContactBlockRepository>(
        () => _i24.ContactBlockRepositoryImpl(gh<_i9.ContactBlockService>()));
    gh.factory<_i25.ImageUploadUseCase>(
        () => _i25.ImageUploadUseCase(gh<_i19.ImageUploadRepository>()));
    gh.factory<_i26.LoginRepository>(
        () => _i27.LoginRepositoryImpl(gh<_i7.OtpService>()));
    gh.factory<_i28.ProfileAcceptUseCase>(
        () => _i28.ProfileAcceptUseCase(gh<_i16.ProfileSwipeRepository>()));
    gh.factory<_i29.ProfileCreateUseCase>(
        () => _i29.ProfileCreateUseCase(gh<_i16.ProfileSwipeRepository>()));
    gh.factory<_i30.ProfileGetRequestedUseCase>(() =>
        _i30.ProfileGetRequestedUseCase(gh<_i16.ProfileSwipeRepository>()));
    gh.factory<_i31.ProfileGetUseCase>(
        () => _i31.ProfileGetUseCase(gh<_i16.ProfileSwipeRepository>()));
    gh.factory<_i32.ProfileRejectUseCase>(
        () => _i32.ProfileRejectUseCase(gh<_i16.ProfileSwipeRepository>()));
    gh.factory<_i33.ProfileSkipUseCase>(
        () => _i33.ProfileSkipUseCase(gh<_i16.ProfileSwipeRepository>()));
    gh.factory<_i34.UserRepository>(
        () => _i35.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i36.UpdateUserStateStreamUseCase>(
        () => _i36.UpdateUserStateStreamUseCase(gh<_i34.UserRepository>()));
    gh.factory<_i37.GetAuthStateStreamUseCase>(
        () => _i37.GetAuthStateStreamUseCase(gh<_i34.UserRepository>()));
    gh.factory<_i38.ContactBlockUseCase>(
        () => _i38.ContactBlockUseCase(gh<_i23.ContactBlockRepository>()));
    gh.factory<_i39.RequestOtpUseCase>(
        () => _i39.RequestOtpUseCase(gh<_i26.LoginRepository>()));
    gh.factory<_i40.SignUpUseCase>(
        () => _i40.SignUpUseCase(gh<_i26.LoginRepository>()));
    gh.factory<_i41.VerifyOtpUseCase>(
        () => _i41.VerifyOtpUseCase(gh<_i26.LoginRepository>()));
    gh.factory<_i42.GetOnboardingStateStreamUseCase>(
        () => _i42.GetOnboardingStateStreamUseCase(gh<_i34.UserRepository>()));
    gh.factory<_i43.UpdateOnboardingStateStreamUseCase>(() =>
        _i43.UpdateOnboardingStateStreamUseCase(gh<_i34.UserRepository>()));
    gh.factory<_i44.CreateProfileUseCase>(
        () => _i44.CreateProfileUseCase(gh<_i21.UpdateProfileRepository>()));
    gh.factory<_i45.UpdateProfileUseCase>(
        () => _i45.UpdateProfileUseCase(gh<_i21.UpdateProfileRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i46.RegisterModule {}
