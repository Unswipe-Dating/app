
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unswipe/src/features/splash/domain/usecases/splash_usecase.dart';
import 'package:unswipe/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../../widgets/utils.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/injections.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  _selectScreen() async {
    if (await Permission.contacts.isGranted) {
      CustomNavigationHelper.router.go(
        CustomNavigationHelper.blockContactPath,
      );
    } else {
      CustomNavigationHelper.router.go(
        CustomNavigationHelper.blockContactPermissionPath,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashBloc(
    splashUseCase: GetIt.I.get<GetAuthStateStreamUseCase>(),
   onboardingStateStreamUseCase: GetIt.I.get<GetOnboardingStateStreamUseCase>()
    )..add(onAuthenticatedUserEvent()),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.loaded) {
          if(state.isFirstTime) {
            CustomNavigationHelper.router.push(
              CustomNavigationHelper.onBoardingPath,
            );
          } else if(!state.isAuthenticated) {
            CustomNavigationHelper.router.push(
              CustomNavigationHelper.loginPath,
            );
          } else {
           _selectScreen();
          }
        }
      },
        // Here I have used BlocBuilder, but instead you can also use BlocListner as well.
        child: Scaffold(
          backgroundColor: Colors.black,

          body: Center(
            child: Image.asset(
              Helper.getImagePath("logo.png"),
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            )
          ),
        ),
      ),
      ),
    );
  }
}