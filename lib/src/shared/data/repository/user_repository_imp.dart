import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/exception/local_data_source_exception.dart';
import '../../../../data/exception/remote_data_source_exception.dart';
import '../../../core/app_error.dart';
import '../../../core/cancellation_exception.dart';
import '../../../core/local_data_source.dart';
import '../../../core/utils/constant/user_and_token_entity.dart';
import '../../../features/onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/repository/user_repository.dart';

part '../../utils/mappers.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final LocalDataSource _localDataSource;

  @override
  final Stream<Result<AuthenticationState>> authenticationState$;

  @override
  final Stream<Result<OnBoardingState>> onboardingState$;



  @override
  VoidResultStream updateOnBoardingState() =>
      _localDataSource.saveOnBoardingToken(
          _Mappers.userResponseToOnBoardingTokenEntity(true)
      ).toEitherStream(_Mappers.errorToAppError);

  @override
  VoidResultStream updateAuthenticationState(String token) =>
      _localDataSource.saveUserAndToken(
          _Mappers.userResponseToUserAndTokenEntity(
            token,
          )
      ).toEitherStream(_Mappers.errorToAppError);




  UserRepositoryImpl(
    this._localDataSource,
  ) : authenticationState$ = _localDataSource.userAndToken$
            .map(_Mappers.userAndTokenEntityToDomainAuthState)
            .toEitherStream(_Mappers.errorToAppError),
        onboardingState$ = _localDataSource.onBoardingToken$
            .map(_Mappers.onBoardingEntityToDomainAuthState)
            .toEitherStream(_Mappers.errorToAppError)

            {
  }





}
