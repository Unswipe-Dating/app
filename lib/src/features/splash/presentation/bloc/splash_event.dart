part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class onLoadingEvent extends SplashEvent {
  onLoadingEvent();
}

// On Fetching Articles Event
class onFirstTimeUserEvent extends SplashEvent {
  onFirstTimeUserEvent();
}


class onGetMetaEvent extends SplashEvent {
  final String token;
  final String userId;
  onGetMetaEvent({required this.token, required this.userId});
}

class OnUpdateOnBoardingUserEvent extends SplashEvent {
  OnUpdateOnBoardingUserEvent();
}

class OnResetUserTokenEvent extends SplashEvent {
  OnResetUserTokenEvent();
}

class onAuthenticatedUserEvent extends SplashEvent {
  onAuthenticatedUserEvent();
}

class onStartChatIntent extends SplashEvent {
  ResponseProfileCreateRequest request;
  String userId;

  onStartChatIntent(this.request, this.userId);
}

class onCheckChatIntent extends SplashEvent {
  ResponseProfileCreateRequest? request;

  onCheckChatIntent(this.request);
}


class onSplashErrorEvent extends SplashEvent {
  onSplashErrorEvent();
}

