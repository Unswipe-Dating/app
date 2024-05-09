part of '../data/repository/user_repository_imp.dart';

abstract class _Mappers {
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
      ..token = entity.token
      ..id = entity.id;

    return AuthenticatedState((b) => b.userAndToken = userAndTokenBuilder);
  }

  static OnBoardingState onBoardingEntityToDomainAuthState(
      OnBoardingStatus? entity) {
    switch(entity) {
      case null: return NotOnBoardedState();
      case OnBoardingStatus.otp: return AuthenticatedStateOnBoarded();
      case OnBoardingStatus.none: return NotOnBoardedState();
      case OnBoardingStatus.init: return OnBoardedState();
      case OnBoardingStatus.contact: return ListBlockedState();
      case OnBoardingStatus.images: return ImageUploadedState();
      case OnBoardingStatus.update: return ProfileUpdateState();
      case OnBoardingStatus.profile: return ProfileUpdatedState();
    }
  }

  /// Response -> Entity
  static OnBoardingStatus? userResponseToOnBoardingTokenEntity(
      OnBoardingStatus? token,
      ) {
    return token;
  }

  /// Response -> Entity
  static UserAndTokenEntity userResponseToUserAndTokenEntity(
    String token,
      String id
  ) {
    return UserAndTokenEntity(
      (b) => b
        ..token = token
        ..id = id
    );
  }
}
