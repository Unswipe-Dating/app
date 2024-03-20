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

class onAuthenticatedUserEvent extends SplashEvent {
  onAuthenticatedUserEvent();
}

class onSplashErrorEvent extends SplashEvent {
  onSplashErrorEvent();
}
