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
    as _i23;
import '../../features/login/domain/repository/login_repository.dart' as _i22;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i30;
import '../../features/login/domain/usecases/signup_login_usecase.dart' as _i31;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i27;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i32;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i33;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i34;
import '../../features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart'
    as _i8;
import '../../features/userOnboarding/contact_block/data/repository/contact_block_repository_impl.dart'
    as _i20;
import '../../features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart'
    as _i19;
import '../../features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart'
    as _i29;
import '../../features/userOnboarding/image_upload/data/datasources/network/image_upload_service.dart'
    as _i9;
import '../../features/userOnboarding/image_upload/data/repository/image_upload_repository_impl.dart'
    as _i16;
import '../../features/userOnboarding/image_upload/domain/repository/image_upload_repository.dart'
    as _i15;
import '../../features/userOnboarding/image_upload/domain/usecase/image_upload_usecase.dart'
    as _i21;
import '../../features/userOnboarding/profile_update/data/datasources/network/service/profile_update_service.dart'
    as _i10;
import '../../features/userOnboarding/profile_update/data/repository/update_profile_repository_impl.dart'
    as _i18;
import '../../features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart'
    as _i17;
import '../../features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart'
    as _i35;
import '../../features/userOnboarding/profile_update/domain/usecases/update_user_use_case.dart'
    as _i36;
import '../../features/userProfile/data/datasources/network/profile_swipe_service.dart'
    as _i11;
import '../../features/userProfile/data/repository/profile_swipe_repository_impl.dart'
    as _i14;
import '../../features/userProfile/domain/repository/profile_swipe_repository.dart'
    as _i13;
import '../../features/userProfile/domain/usecase/profile_swap_usecase.dart'
    as _i24;
import '../../shared/data/repository/user_repository_imp.dart' as _i26;
import '../../shared/domain/repository/user_repository.dart' as _i25;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i28;
import '../local_data_source.dart' as _i5;
import '../network/graphql/graphql_service.dart' as _i4;
import '../shared_pref_util.dart' as _i12;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i37;

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
    gh.factory<_i8.ContactBlockService>(
        () => _i8.ContactBlockService(gh<_i4.GraphQLService>()));
    gh.factory<_i9.ImageUploadService>(
        () => _i9.ImageUploadService(gh<_i4.GraphQLService>()));
    gh.factory<_i10.UpdateUserService>(
        () => _i10.UpdateUserService(gh<_i4.GraphQLService>()));
    gh.factory<_i11.ProfileSwipeService>(
        () => _i11.ProfileSwipeService(gh<_i4.GraphQLService>()));
    gh.factory<_i5.LocalDataSource>(() => _i12.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i13.ProfileSwipeRepository>(
        () => _i14.ProfileSwipeRepositoryImpl(gh<_i11.ProfileSwipeService>()));
    gh.factory<_i15.ImageUploadRepository>(
        () => _i16.ImageUploadRepositoryImpl(gh<_i9.ImageUploadService>()));
    gh.factory<_i17.UpdateProfileRepository>(
        () => _i18.UpdateProfileRepositoryImpl(gh<_i10.UpdateUserService>()));
    gh.factory<_i19.ContactBlockRepository>(
        () => _i20.ContactBlockRepositoryImpl(gh<_i8.ContactBlockService>()));
    gh.factory<_i21.ImageUploadUseCase>(
        () => _i21.ImageUploadUseCase(gh<_i15.ImageUploadRepository>()));
    gh.factory<_i22.LoginRepository>(
        () => _i23.LoginRepositoryImpl(gh<_i7.OtpService>()));
    gh.factory<_i24.ProfileSwipeUseCase>(
        () => _i24.ProfileSwipeUseCase(gh<_i13.ProfileSwipeRepository>()));
    gh.factory<_i25.UserRepository>(
        () => _i26.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i27.UpdateUserStateStreamUseCase>(
        () => _i27.UpdateUserStateStreamUseCase(gh<_i25.UserRepository>()));
    gh.factory<_i28.GetAuthStateStreamUseCase>(
        () => _i28.GetAuthStateStreamUseCase(gh<_i25.UserRepository>()));
    gh.factory<_i29.ContactBlockUseCase>(
        () => _i29.ContactBlockUseCase(gh<_i19.ContactBlockRepository>()));
    gh.factory<_i30.RequestOtpUseCase>(
        () => _i30.RequestOtpUseCase(gh<_i22.LoginRepository>()));
    gh.factory<_i31.SignUpUseCase>(
        () => _i31.SignUpUseCase(gh<_i22.LoginRepository>()));
    gh.factory<_i32.VerifyOtpUseCase>(
        () => _i32.VerifyOtpUseCase(gh<_i22.LoginRepository>()));
    gh.factory<_i33.GetOnboardingStateStreamUseCase>(
        () => _i33.GetOnboardingStateStreamUseCase(gh<_i25.UserRepository>()));
    gh.factory<_i34.UpdateOnboardingStateStreamUseCase>(() =>
        _i34.UpdateOnboardingStateStreamUseCase(gh<_i25.UserRepository>()));
    gh.factory<_i35.CreateProfileUseCase>(
        () => _i35.CreateProfileUseCase(gh<_i17.UpdateProfileRepository>()));
    gh.factory<_i36.UpdateProfileUseCase>(
        () => _i36.UpdateProfileUseCase(gh<_i17.UpdateProfileRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i37.RegisterModule {}
