
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unswipe/router/pages/HomePage.dart';
import 'package:unswipe/router/pages/LoginPage.dart';

import '../data/auth_repository.dart';
import 'pages/OnBoardingPage.dart';


class MyAppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AuthRepository authRepository;

  bool? _loggedIn;
  bool? get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

  bool? _isNew;
  bool? get isNew => _isNew;
  set isNew(value) {
    _isNew = value;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate(this.authRepository) {
    _init();
  }

  _init() async {
    isNew = await authRepository.isUserNew();
    loggedIn = await authRepository.isUserLoggedIn();
    if (loggedIn == true) {
      // do some login shenanigans
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    final loggedIn = this.loggedIn;
    final isNew = this.isNew;


    // final colors = this.colors;
    if (isNew == null || !isNew ) {
      stack = _newStack;
    } else if (loggedIn == null || !loggedIn) {
      stack = _loggedOutStack;
    } else {
      stack = _loggedInStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
    );
  }

  List<Page> get _newStack => [
        OnboardingPage(onLogin: () async {
          isNew = true;
        })
      ];

  List<Page> get _loggedOutStack => [
    LoginPage(onLogin: () async {
      loggedIn = true;
    })
  ];

  List<Page> get _loggedInStack => [
    HomePage()
  ];

  _clear() {
  }

  Future<void> setNewRoutePath(configuration) async {/* Do Nothing */}
}
