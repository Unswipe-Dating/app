import 'package:flutter/material.dart';
import 'package:unswipe/OnBoarding.dart';


class OnboardingPage extends Page {
  final VoidCallback onLogin;

  const OnboardingPage({required this.onLogin}) :
        super();

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return OnBoardingScreen(onLogin:
        onLogin);
      },
    );
  }
}
