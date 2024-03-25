import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/core/app_error.dart';
import 'package:unswipe/src/shared/domain/entities/auth_state.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart';

import '../../../../core/network/error/failures.dart';
import '../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetAuthStateStreamUseCase splashUseCase;
  final GetOnboardingStateStreamUseCase onboardingStateStreamUseCase;

   late StreamSubscription _subscription;
   late StreamSubscription _subscription1;


  // List of splash

  SplashBloc({required this.splashUseCase,
    required this.onboardingStateStreamUseCase,
  })
      : super(SplashState()) {
    on<onAuthenticatedUserEvent>(_onGettingSplashEvent);
    on<onFirstTimeUserEvent>(_onGettingOnBoardingEvent);

  }

  _onGettingOnBoardingEvent(onFirstTimeUserEvent event,
      Emitter<SplashState> emitter) async {

    _subscription = onboardingStateStreamUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(state.copyWith(status: SplashStatus.error));
        } else {
          emitter(state.copyWith(status: SplashStatus.error));
        }
      },
          ifRight: (r) {
            if(r is NotOnBoardedState) {
              emitter(state.copyWith(status: SplashStatus.loaded,
                  isFirstTime: true,
                  isAuthenticated: false,

              ));

            } else {
              if (!state.isBoardedAhead) {
                emitter(state.copyWith(
                  status: SplashStatus.loaded,
                  isFirstTime: false,
                  isAuthenticated: false,
                  isBoardedAhead: true
                ));
              }

            }
          });
    });
  }

// Getting splash event
  _onGettingSplashEvent(onAuthenticatedUserEvent event, Emitter<SplashState> emitter) async {

    _subscription1 = splashUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(state.copyWith(status: SplashStatus.error));
        } else {
          emitter(state.copyWith(status: SplashStatus.error));
        }
      },
          ifRight: (r) {
        if(r is AuthenticatedState) {
          emitter(state.copyWith(status: SplashStatus.loaded,
              isAuthenticated: true,
              isFirstTime: false));
        } else {
          add(onFirstTimeUserEvent());
        }
        });
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _subscription1.cancel();
    return super.close();
  }


// This function is called whenever the text field changes

}
