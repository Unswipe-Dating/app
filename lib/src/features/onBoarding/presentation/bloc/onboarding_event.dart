part of 'onboarding_bloc.dart';

abstract class OnBoardingEvent {
  const OnBoardingEvent();
}

class OnUpdateOnBoardingUserEvent extends OnBoardingEvent {
  OnUpdateOnBoardingUserEvent();
}
