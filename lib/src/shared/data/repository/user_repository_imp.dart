import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:unswipe/src/core/utils/streams.dart';
import 'package:unswipe/src/features/onBoarding/presentation/bloc/onboarding_bloc.dart';
import 'package:unswipe/src/shared/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../data/exception/local_data_source_exception.dart';
import '../../../../data/exception/remote_data_source_exception.dart';
import '../../../core/app_error.dart';
import '../../../core/cancellation_exception.dart';
import '../../../core/local_data_source.dart';
import '../../../core/utils/constant/user_and_token_entity.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/repository/user_repository.dart';

part 'mappers.dart';

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



  UserRepositoryImpl(
    this._localDataSource,
  ) : authenticationState$ = _localDataSource.userAndToken$
            .map(_Mappers.userAndTokenEntityToDomainAuthState)
            .toEitherStream(_Mappers.errorToAppError),
        onboardingState$ = _localDataSource.onBoardingToken$
            .map(_Mappers.onBoardingEntityToDomainAuthState)
            .toEitherStream(_Mappers.errorToAppError)

            {
    _init().ignore();
  }

  Future<void> _init() async {
    const tag = '[USER_REPOSITORY] { init }';

    try {
      final userAndToken = await _localDataSource.userAndToken$.first;
      debugPrint('$tag userAndToken local=$userAndToken');

      if (userAndToken == null) {
        return;
      }

      await _localDataSource
          .saveUserAndToken(
            _Mappers.userResponseToUserAndTokenEntity(
              userAndToken.token,
            ),
          )
          .first;
    } on RemoteDataSourceException catch (e) {
      debugPrint('$tag remote error=$e');
    } on LocalDataSourceException catch (e) {
      debugPrint('$tag local error=$e');
      await _localDataSource.removeUserAndToken().first;
    }
  }

}
