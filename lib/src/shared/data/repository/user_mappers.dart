part of 'user_repository_imp.dart';

abstract class _UserMappers {
  ///
  /// Convert error to [Failure]
  ///
  static AppError errorToAppError(Object e, StackTrace s) {
    if (e is CancellationException) {
      return const AppCancellationError();
    }

    if (e is RemoteDataSourceException) {
      if (e.error is CancellationException) {
        return const AppCancellationError();
      }
      return AppError(
        message: e.message,
        error: e,
        stackTrace: s,
      );
    }

    if (e is LocalDataSourceException) {
      if (e.error is CancellationException) {
        return const AppCancellationError();
      }
      return AppError(
        message: e.message,
        error: e,
        stackTrace: s,
      );
    }

    return AppError(
      message: e.toString(),
      error: e,
      stackTrace: s,
    );
  }

  /// Entity -> Domain
  static AuthenticationState userAndTokenEntityToDomainAuthState(
      UserAndTokenEntity? entity) {
    if (entity == null) {
      return UnauthenticatedState();
    }

    final userAndTokenBuilder = UserAndTokenEntityBuilder()
      ..token = entity.token;

    return AuthenticatedState((b) => b.userAndToken = userAndTokenBuilder);
  }

  /// Response -> Entity
  static UserAndTokenEntity userResponseToUserAndTokenEntity(
    String token,
  ) {
    return UserAndTokenEntity(
      (b) => b
        ..token = token
    );
  }
}
