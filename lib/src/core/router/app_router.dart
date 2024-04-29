import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/some_main.dart';
import 'package:unswipe/src/features/chat/no_request_individual_screen.dart';
import 'package:unswipe/src/features/chat/no_request_screen.dart';
import 'package:unswipe/src/features/community/community_tab_page_check.dart';
import 'package:unswipe/src/features/home/home.dart';
import 'package:unswipe/src/features/hyperExclusiveMatch/hyper_ex_request_lock_page.dart';

import 'package:unswipe/src/features/hyperExclusiveMatch/hyper_exclusive_page.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/onBoarding/presentation/pages/OnBoarding.dart';
import 'package:unswipe/src/features/splash/presentation/pages/splash_page.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/contact_block_init_screen.dart';
import 'package:unswipe/widgets/homePage/dart_swiper.dart';

import '../../features/chat/chat_request_screen.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
  CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> profileTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> chatTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> communityTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
  GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String splashPath = '/splash';
  static const String loginPath = '/login';
  static const String onBoardingPath = '/onboarding';
  static const String rootDetailPath = '/rootDetail';

  static const String profilePath = '/profile';
  static const String profilePathHyperEx = '/hyperex';
  static const String profilePathHyperExLock = '/profile/hyperex';

  static const String blockContactPermissionPath = '/permission';
  static const String blockContactPath = '/contact';

  static const String chatRequestPath = '/chat/chatRequest';


  static const String chatPath = '/chat';
  static const String communityPath = '/community';
  static const String settingsPath = '/settings';


  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: profileTabNavigatorKey,
            routes: [
              GoRoute(
                path: profilePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const SwipeInterface(),
                    state: state,
                  );
                },
              ),
              GoRoute(
                path:  profilePathHyperExLock,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HyperExclusiveRequestLockScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: chatTabNavigatorKey,
            routes: [
              GoRoute(
                path: chatPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ChatRequestListPage(),
                    state: state,
                  );
                },
              ),
              GoRoute(
                path: chatRequestPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const NoRequestScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: communityTabNavigatorKey,
            routes: [
              GoRoute(
                path: communityPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: RoundTabBarPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsTabNavigatorKey,
            routes: [
              GoRoute(
                path: settingsPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const SwipeInterface(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
        pageBuilder: (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
            ) {
          return getPage(
            child: MyHomePage(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: blockContactPermissionPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const BlockContactInitPage(),
            state: state,
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: blockContactPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const BlockContactInitPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: splashPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SplashScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: profilePathHyperEx,
        pageBuilder: (context, state) {
          String uri = state.extra as String;
          return getPage(
            child: HyperExclusiveRequestPage(uri: uri),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: loginPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const LoginScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: onBoardingPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const OnBoardingScreen(),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: splashPath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}

