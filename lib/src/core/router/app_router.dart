import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/Login.dart';
import 'package:unswipe/OnBoarding.dart';
import 'package:unswipe/src/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return SplashPage();
        },
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen(onLogin:(){});
        },
      ),

    ],
  );
}
