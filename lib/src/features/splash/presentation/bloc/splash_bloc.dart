import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/shared/domain/entities/auth_state.dart';
import 'package:unswipe/src/shared/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/get_onboarding_state_stream_use_case.dart';
import 'package:unswipe/src/shared/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../core/network/error/failures.dart';
part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetAuthStateStreamUseCase splashUseCase;
  final GetOnboardingStateStreamUseCase onboardingStateStreamUseCase;
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;

  // List of splash

  SplashBloc({required this.splashUseCase,
    required this.onboardingStateStreamUseCase,
    required this.updateOnboardingStateStreamUseCase
  })
      : super(SplashState()) {
    on<onAuthenticatedUserEvent>(_onGettingSplashEvent);
    on<onFirstTimeUserEvent>(_onGettingOnBoardingEvent);
    on<onFirstTimeUserEvent>(_onGettingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(onFirstTimeUserEvent event,
      Emitter<SplashState> emitter) async {

    updateOnboardingStateStreamUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        } else {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        }
      },
          ifRight: (r) {
              emitter(SplashState().copyWith(
                  status: SplashStatus.loaded,
                  isFirstTime: true,
                  isAuthenticated: false
              ));

          });
    });
  }

  _onGettingOnBoardingEvent(onFirstTimeUserEvent event,
      Emitter<SplashState> emitter) async {

    onboardingStateStreamUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        } else {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        }
      },
          ifRight: (r) {
            if(r is NotOnBoardedState) {
              emitter(SplashState().copyWith(status: SplashStatus.loaded, isFirstTime: true, isAuthenticated: false ));

            } else {
              emitter(SplashState().copyWith(status: SplashStatus.loaded, isFirstTime: false, isAuthenticated: false ));

            }
          });
    });
  }

// Getting splash event
  _onGettingSplashEvent(onAuthenticatedUserEvent event, Emitter<SplashState> emitter) async {

    splashUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        } else {
          emitter(SplashState().copyWith(status: SplashStatus.error));
        }
      },
          ifRight: (r) {
        if(r is AuthenticatedState) {
          emitter(SplashState().copyWith(status: SplashStatus.loaded,
              isAuthenticated: true,
              isFirstTime: false));
        } else {
          add(onFirstTimeUserEvent());
        }
        });
    });
  }

// This function is called whenever the text field changes

}
