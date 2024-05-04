import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/shared/domain/entities/auth_state.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart';
import '../../../../../data/api_response.dart';
import '../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetOnboardingStateStreamUseCase onboardingStateStreamUseCase;

  StreamSubscription? subscription;

  SplashBloc({
    required this.onboardingStateStreamUseCase,
  }) : super(const SplashState()) {
    on<onFirstTimeUserEvent>(_onGettingOnBoardingEvent);
  }

  _onGettingOnBoardingEvent(
      onFirstTimeUserEvent event, Emitter<SplashState> emitter) async {
    await emitter.forEach(onboardingStateStreamUseCase.call(), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: SplashStatus.error);
        } else {
          return state.copyWith(status: SplashStatus.error);
        }
      }, ifRight: (r) {
        if (r is NotOnBoardedState) {
          return state.copyWith(
            status: SplashStatus.loaded,
            isFirstTime: true,
            isAuthenticated: false,
          );
        } else if (r is ProfileUpdatedState) {
          return state.copyWith(
            status: SplashStatus.loaded,
            isFirstTime: false,
            isAuthenticated: true,
            isBoardedAhead: true,
            isUserJourneyComplete: true,
          );
        } else {
            return state.copyWith(
                status: SplashStatus.loaded,
                isFirstTime: false,
                isAuthenticated: false,
                isBoardedAhead: true);

        }
      });
    });
  }

// Getting splash event

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
