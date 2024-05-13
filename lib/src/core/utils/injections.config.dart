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
    as _i9;
import '../../features/login/data/repository/login_repository_impl.dart'
    as _i25;
import '../../features/login/domain/repository/login_repository.dart' as _i24;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i33;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i29;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i34;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i35;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i36;
import '../../features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart'
    as _i10;
import '../../features/userOnboarding/contact_block/data/repository/contact_block_repository_impl.dart'
    as _i22;
import '../../features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart'
    as _i21;
import '../../features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart'
    as _i31;
import '../../features/userOnboarding/image_upload/data/datasources/network/image_upload_service.dart'
    as _i12;
import '../../features/userOnboarding/image_upload/data/repository/image_upload_repository_impl.dart'
    as _i18;
import '../../features/userOnboarding/image_upload/domain/repository/image_upload_repository.dart'
    as _i17;
import '../../features/userOnboarding/image_upload/domain/usecase/image_upload_usecase.dart'
    as _i32;
import '../../features/userOnboarding/profile_update/data/datasources/network/service/profile_update_service.dart'
    as _i13;
import '../../features/userOnboarding/profile_update/data/repository/update_profile_repository_impl.dart'
    as _i20;
import '../../features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart'
    as _i19;
import '../../features/userOnboarding/profile_update/domain/usecases/block_contact_usecase.dart'
    as _i5;
import '../../features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart'
    as _i6;
import '../../features/userOnboarding/profile_update/domain/usecases/upload_images_use_case.dart'
    as _i23;
import '../../features/userProfile/data/datasources/network/profile_swipe_service.dart'
    as _i11;
import '../../features/userProfile/data/repository/profile_swipe_repository_impl.dart'
    as _i16;
import '../../features/userProfile/domain/repository/profile_swipe_repository.dart'
    as _i15;
import '../../features/userProfile/domain/usecase/profile_swap_usecase.dart'
    as _i26;
import '../../shared/data/repository/user_repository_imp.dart' as _i28;
import '../../shared/domain/repository/user_repository.dart' as _i27;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i30;
import '../local_data_source.dart' as _i7;
import '../network/graphql/graphql_service.dart' as _i4;
import '../shared_pref_util.dart' as _i14;
import 'constant/method_channel_crypto_impl.dart' as _i8;
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
    gh.factory<_i5.BlockContactUseCase>(
        () => _i5.BlockContactUseCase(gh<InvalidType>()));
    gh.factory<_i6.CreateUserUseCase>(
        () => _i6.CreateUserUseCase(gh<InvalidType>()));
    gh.factory<_i7.Crypto>(() => _i8.MethodChannelCryptoImpl());
    gh.factory<_i9.OtpService>(() => _i9.OtpService(gh<_i4.GraphQLService>()));
    gh.factory<_i10.ContactBlockService>(
        () => _i10.ContactBlockService(gh<_i4.GraphQLService>()));
    gh.factory<_i11.ProfileSwipeService>(
        () => _i11.ProfileSwipeService(gh<_i4.GraphQLService>()));
    gh.factory<_i12.ImageUploadService>(
        () => _i12.ImageUploadService(gh<_i4.GraphQLService>()));
    gh.factory<_i13.UserOnboardingService>(
        () => _i13.UserOnboardingService(gh<_i4.GraphQLService>()));
    gh.factory<_i7.LocalDataSource>(() => _i14.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i7.Crypto>(),
        ));
    gh.factory<_i15.ProfileSwipeRepository>(
        () => _i16.ProfileSwipeRepositoryImpl(gh<_i11.ProfileSwipeService>()));
    gh.factory<_i17.ImageUploadRepository>(
        () => _i18.ImageUploadRepositoryImpl(gh<_i12.ImageUploadService>()));
    gh.factory<_i19.UserOnboardingRepository>(() =>
        _i20.UserOnboardingRepositoryImpl(gh<_i13.UserOnboardingService>()));
    gh.factory<_i21.ContactBlockRepository>(
        () => _i22.ContactBlockRepositoryImpl(gh<_i10.ContactBlockService>()));
    gh.factory<_i23.UploadImageUseCase>(
        () => _i23.UploadImageUseCase(gh<_i19.UserOnboardingRepository>()));
    gh.factory<_i24.LoginRepository>(
        () => _i25.LoginRepositoryImpl(gh<_i9.OtpService>()));
    gh.factory<_i26.ProfileSwipeUseCase>(
        () => _i26.ProfileSwipeUseCase(gh<_i15.ProfileSwipeRepository>()));
    gh.factory<_i27.UserRepository>(
        () => _i28.UserRepositoryImpl(gh<_i7.LocalDataSource>()));
    gh.factory<_i29.UpdateUserStateStreamUseCase>(
        () => _i29.UpdateUserStateStreamUseCase(gh<_i27.UserRepository>()));
    gh.factory<_i30.GetAuthStateStreamUseCase>(
        () => _i30.GetAuthStateStreamUseCase(gh<_i27.UserRepository>()));
    gh.factory<_i31.ContactBlockUseCase>(
        () => _i31.ContactBlockUseCase(gh<_i21.ContactBlockRepository>()));
    gh.factory<_i32.ContactBlockUseCase>(
        () => _i32.ContactBlockUseCase(gh<_i21.ContactBlockRepository>()));
    gh.factory<_i33.RequestOtpUseCase>(
        () => _i33.RequestOtpUseCase(gh<_i24.LoginRepository>()));
    gh.factory<_i34.VerifyOtpUseCase>(
        () => _i34.VerifyOtpUseCase(gh<_i24.LoginRepository>()));
    gh.factory<_i35.GetOnboardingStateStreamUseCase>(
        () => _i35.GetOnboardingStateStreamUseCase(gh<_i27.UserRepository>()));
    gh.factory<_i36.UpdateOnboardingStateStreamUseCase>(() =>
        _i36.UpdateOnboardingStateStreamUseCase(gh<_i27.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i37.RegisterModule {}
