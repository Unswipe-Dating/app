import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';
import 'package:unswipe/src/shared/domain/entities/onbaording_state/onboarding_state.dart';

import '../../../../data/exception/local_data_source_exception.dart';
import '../../../../data/exception/remote_data_source_exception.dart';
import '../../../core/app_error.dart';
import '../../../core/cancellation_exception.dart';
import '../../../core/local_data_source.dart';
import '../../../core/utils/constant/user_and_token_entity.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/repository/user_repository.dart';

part 'user_mappers.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource _localDataSource;

  @override
  final Stream<Result<AuthenticationState>> authenticationState$;

  UserRepositoryImpl(
    this._localDataSource,
  ) : authenticationState$ = _localDataSource.userAndToken$
            .map(_UserMappers.userAndTokenEntityToDomainAuthState)
            .toEitherStream(_UserMappers.errorToAppError)
            {
    _init().ignore();
  }

  

  // @override
  // UnitResultSingle login({
  //   required String email,
  //   required String password,
  // }) {
  //   return _remoteDataSource
  //       .loginUser(email, password)
  //       .toEitherSingle(_Mappers.errorToAppError)
  //       .flatMapEitherSingle((result) {
  //         final token = result.token!;
  //
  //         return _remoteDataSource
  //             .getUserProfile(email, token)
  //             .map((user) => Tuple2(user, token))
  //             .toEitherSingle(_Mappers.errorToAppError);
  //       })
  //       .flatMapEitherSingle(
  //         (tuple) => _localDataSource
  //             .saveUserAndToken(
  //               _Mappers.userResponseToUserAndTokenEntity(
  //                 tuple.item1,
  //                 tuple.item2,
  //               ),
  //             )
  //             .toEitherSingle(_Mappers.errorToAppError),
  //       )
  //       .asUnit();
  // }
  //
  // @override
  // UnitResultSingle registerUser({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) =>
  //     _remoteDataSource
  //         .registerUser(name, email, password)
  //         .toEitherSingle(_Mappers.errorToAppError)
  //         .asUnit();
  //
  // @override
  // UnitResultSingle logout() => _localDataSource
  //     .removeUserAndToken()
  //     .toEitherSingle(_Mappers.errorToAppError)
  //     .asUnit();
  //
  // @override
  // UnitResultSingle uploadImage(File image) {
  //   return _userAndToken
  //       .flatMapEitherSingle((userAndToken) {
  //         if (userAndToken == null) {
  //           return Single.value(
  //             AppError(
  //               message: 'Require login!',
  //               error: 'Email or token is null',
  //               stackTrace: StackTrace.current,
  //             ).left(),
  //           );
  //         }
  //
  //         return _remoteDataSource
  //             .uploadImage(
  //               image,
  //               userAndToken.user.email,
  //               userAndToken.token,
  //             )
  //             .map((user) => Tuple2(user, userAndToken.token))
  //             .toEitherSingle(_Mappers.errorToAppError);
  //       })
  //       .flatMapEitherSingle(
  //         (tuple) => _localDataSource
  //             .saveUserAndToken(
  //               _Mappers.userResponseToUserAndTokenEntity(
  //                 tuple.item1,
  //                 tuple.item2,
  //               ),
  //             )
  //             .toEitherSingle(_Mappers.errorToAppError),
  //       )
  //       .asUnit();
  // }
  //
  // @override
  // UnitResultSingle changePassword({
  //   required String password,
  //   required String newPassword,
  // }) {
  //   return _userAndToken.flatMapEitherSingle((userAndToken) {
  //     if (userAndToken == null) {
  //       return Single.value(
  //         AppError(
  //           message: 'Require login!',
  //           error: 'Email or token is null',
  //           stackTrace: StackTrace.current,
  //         ).left(),
  //       );
  //     }
  //
  //     return _remoteDataSource
  //         .changePassword(
  //           userAndToken.user.email,
  //           password,
  //           newPassword,
  //           userAndToken.token,
  //         )
  //         .toEitherSingle(_Mappers.errorToAppError)
  //         .asUnit();
  //   });
  // }
  //
  // @override
  // UnitResultSingle resetPassword({
  //   required String email,
  //   required String token,
  //   required String newPassword,
  // }) =>
  //     _remoteDataSource
  //         .resetPassword(
  //           email,
  //           token: token,
  //           newPassword: newPassword,
  //         )
  //         .toEitherSingle(_Mappers.errorToAppError)
  //         .asUnit();
  //
  // @override
  // UnitResultSingle sendResetPasswordEmail(String email) => _remoteDataSource
  //     .resetPassword(email)
  //     .toEitherSingle(_Mappers.errorToAppError)
  //     .asUnit();
  //
  // ///
  // /// Helpers functions
  // ///
  //
  // /// TODO: Replace with interceptor
  // Stream<Result<UserAndTokenEntity?>> get _userAndToken =>
  //     _localDataSource.userAndToken.toEitherSingle(_Mappers.errorToAppError);
  //
  // ///
  // /// Check auth when starting app
  // ///
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
            _UserMappers.userResponseToUserAndTokenEntity(
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
