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
    as _i19;
import '../../features/login/domain/repository/login_repository.dart' as _i18;
import '../../features/login/domain/usecases/request_otp_use_case.dart' as _i29;
import '../../features/login/domain/usecases/update_login_state_stream_usecase.dart'
    as _i26;
import '../../features/login/domain/usecases/verify_otp_use_case.dart' as _i30;
import '../../features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart'
    as _i31;
import '../../features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart'
    as _i32;
import '../../features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart'
    as _i9;
import '../../features/userOnboarding/contact_block/data/repository/contact_block_repository_impl.dart'
    as _i15;
import '../../features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart'
    as _i14;
import '../../features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart'
    as _i28;
import '../../features/userOnboarding/data/datasources/network/service/user_onboarding_service.dart'
    as _i8;
import '../../features/userOnboarding/data/repository/on_boarding_user_repository_impl.dart'
    as _i17;
import '../../features/userOnboarding/domain/repository/on_boarding_user_repository.dart'
    as _i16;
import '../../features/userOnboarding/domain/usecases/block_contact_usecase.dart'
    as _i23;
import '../../features/userOnboarding/domain/usecases/create_user_use_case.dart'
    as _i24;
import '../../features/userOnboarding/domain/usecases/upload_images_use_case.dart'
    as _i25;
import '../../features/userProfile/data/datasources/network/profile_swipe_service.dart'
    as _i10;
import '../../features/userProfile/data/repository/profile_swipe_repository_impl.dart'
    as _i13;
import '../../features/userProfile/domain/repository/profile_swipe_repository.dart'
    as _i12;
import '../../features/userProfile/domain/usecase/profile_swap_usecase.dart'
    as _i20;
import '../../shared/data/repository/user_repository_imp.dart' as _i22;
import '../../shared/domain/repository/user_repository.dart' as _i21;
import '../../shared/domain/usecases/get_auth_state_stream_use_case.dart'
    as _i27;
import '../local_data_source.dart' as _i5;
import '../network/graphql/graphql_service.dart' as _i4;
import '../shared_pref_util.dart' as _i11;
import 'constant/method_channel_crypto_impl.dart' as _i6;
import 'usecases/usecase_module.dart' as _i33;

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
    gh.factory<_i9.ContactBlockService>(
        () => _i9.ContactBlockService(gh<_i4.GraphQLService>()));
    gh.factory<_i10.ProfileSwipeService>(
        () => _i10.ProfileSwipeService(gh<_i4.GraphQLService>()));
    gh.factory<_i5.LocalDataSource>(() => _i11.SharedPrefUtil(
          gh<_i3.RxSharedPreferences>(),
          gh<_i5.Crypto>(),
        ));
    gh.factory<_i12.ProfileSwipeRepository>(
        () => _i13.ProfileSwipeRepositoryImpl(gh<_i10.ProfileSwipeService>()));
    gh.factory<_i14.ContactBlockRepository>(
        () => _i15.ContactBlockRepositoryImpl(gh<_i9.ContactBlockService>()));
    gh.factory<_i16.UserOnboardingRepository>(() =>
        _i17.UserOnboardingRepositoryImpl(gh<_i8.UserOnboardingService>()));
    gh.factory<_i18.LoginRepository>(
        () => _i19.LoginRepositoryImpl(gh<_i7.OtpService>()));
    gh.factory<_i20.ProfileSwipeUseCase>(
        () => _i20.ProfileSwipeUseCase(gh<_i12.ProfileSwipeRepository>()));
    gh.factory<_i21.UserRepository>(
        () => _i22.UserRepositoryImpl(gh<_i5.LocalDataSource>()));
    gh.factory<_i23.BlockContactUseCase>(
        () => _i23.BlockContactUseCase(gh<_i16.UserOnboardingRepository>()));
    gh.factory<_i24.CreateUserUseCase>(
        () => _i24.CreateUserUseCase(gh<_i16.UserOnboardingRepository>()));
    gh.factory<_i25.UploadImageUseCase>(
        () => _i25.UploadImageUseCase(gh<_i16.UserOnboardingRepository>()));
    gh.factory<_i26.UpdateUserStateStreamUseCase>(
        () => _i26.UpdateUserStateStreamUseCase(gh<_i21.UserRepository>()));
    gh.factory<_i27.GetAuthStateStreamUseCase>(
        () => _i27.GetAuthStateStreamUseCase(gh<_i21.UserRepository>()));
    gh.factory<_i28.ContactBlockUseCase>(
        () => _i28.ContactBlockUseCase(gh<_i14.ContactBlockRepository>()));
    gh.factory<_i29.RequestOtpUseCase>(
        () => _i29.RequestOtpUseCase(gh<_i18.LoginRepository>()));
    gh.factory<_i30.VerifyOtpUseCase>(
        () => _i30.VerifyOtpUseCase(gh<_i18.LoginRepository>()));
    gh.factory<_i31.GetOnboardingStateStreamUseCase>(
        () => _i31.GetOnboardingStateStreamUseCase(gh<_i21.UserRepository>()));
    gh.factory<_i32.UpdateOnboardingStateStreamUseCase>(() =>
        _i32.UpdateOnboardingStateStreamUseCase(gh<_i21.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i33.RegisterModule {}
