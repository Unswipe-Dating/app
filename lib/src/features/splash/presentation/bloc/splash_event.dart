part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

// On Fetching Articles Event
class OnGettingSplashEvent extends SplashEvent {
  final String text;
  final int period;
  final bool withLoading;

  OnGettingSplashEvent(this.text, this.period,
      {this.withLoading = true});
}
