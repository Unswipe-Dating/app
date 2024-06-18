import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/reset_user_token_state_stream_usecase.dart';
import 'package:unswipe/src/features/splash/domain/usecases/meta_usecase.dart';
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
        CustomNavigationHelper.blockContactPermissionPath,
      );
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
        onboardingStateStreamUseCase: GetIt.I.get<GetOnboardingStateStreamUseCase>(),
        metaUseCase: GetIt.I.get<MetaUseCase>(),
        getAuthStateStreamUseCase: GetIt.I.get<GetAuthStateStreamUseCase>(),
        updateOnboardingStateStreamUseCase: GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
        resetUserTokenStateStreamUseCase: GetIt.I.get<ResetUserTokenStateStreamUseCase>(),
      )
        ..add(onAuthenticatedUserEvent()),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state.status == SplashStatus.loaded) {
              if (state.isFirstTime) {
                CustomNavigationHelper.router.go(
                  CustomNavigationHelper.onBoardingPath,
                );
              } else if (!state.isAuthenticated) {
                CustomNavigationHelper.router.go(
                  CustomNavigationHelper.loginPath,
                );
              } else {
                if (state.isUserJourneyComplete) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.profilePath,
                  );
                }
                else if (state.isImageUploaded) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.uploadImagePath,
                  );
                }
                else if (state.isContactsBlocked) {
                  _selectScreen();
                }
                else if (state.isProfileUpdated) {
                  CustomNavigationHelper.router.go(
                    CustomNavigationHelper.onboardingNamePath,
                  );
                }
                else if (state.isProfileMatchRequested) {
                  CustomNavigationHelper.router
                      .go(CustomNavigationHelper.profilePathHyperEx, extra: "" );
                }
                else {
                  _selectScreen();
                }
              }
            }
            else if (state.status == SplashStatus.loadedChat) {
              CustomNavigationHelper.router.go(
                CustomNavigationHelper.startChatPath,
                extra: state.chatParams
              );
            }
            else if (state.status == SplashStatus.errorAuth) {
              CustomNavigationHelper.router.go(
                CustomNavigationHelper.loginPath,
              );
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
            )),
          ),
        ),
      ),
    );
  }
}
