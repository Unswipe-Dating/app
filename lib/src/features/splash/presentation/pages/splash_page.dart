
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/src/features/splash/domain/usecases/splash_usecase.dart';
import 'package:unswipe/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/get_onboarding_state_stream_use_case.dart';

import '../../../../../widgets/utils.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/utils/injections.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashBloc(
          splashUseCase: sl<GetAuthStateStreamUseCase>(),
          onboardingStateStreamUseCase: sl<GetOnboardingStateStreamUseCase>()
      )
        ..add(onAuthenticatedUserEvent()),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.loaded) {
          if(state.isFirstTime) {
            context.goNamed('onboarding');
          } else if(state.isAuthenticated) {
            context.goNamed('login');
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