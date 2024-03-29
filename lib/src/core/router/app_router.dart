import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/src/features/home/home.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/onBoarding/presentation/pages/OnBoarding.dart';
import 'package:unswipe/src/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (BuildContext context,
            GoRouterState state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return OnBoardingScreen();
        },
      ),
      GoRoute(
        name: 'profile',
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return MyHomePage(title: "title");
        },
      ),

    ],
  );

  static GoRouter get router => _router;

  void clearStackAndNavigate(BuildContext context, String path) {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }

    GoRouter.of(context).pushReplacement(path);
  }

}
