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
  onGetMetaEvent({required this.token});
}

class onUpdateOnBoardingUserEvent extends SplashEvent {
  onUpdateOnBoardingUserEvent();
}

class onAuthenticatedUserEvent extends SplashEvent {
  onAuthenticatedUserEvent();
}

class onSplashErrorEvent extends SplashEvent {
  onSplashErrorEvent();
}

