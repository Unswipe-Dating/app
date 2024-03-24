import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/Login.dart';
import 'package:unswipe/OnBoarding.dart';
import 'package:unswipe/src/features/splash/presentation/pages/splash_page.dart';
import 'package:unswipe/widgets/homePage/dart_swiper.dart';

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
          return LoginScreen(onLogin:(){});
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
          return SwipeInterface();
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
