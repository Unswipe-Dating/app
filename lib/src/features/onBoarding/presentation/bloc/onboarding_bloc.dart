import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/shared/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../core/network/error/failures.dart';


part 'onboarding_event.dart';
part 'onboard_state.dart';


class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;

  // List of splash

  OnBoardingBloc({
    required this.updateOnboardingStateStreamUseCase
  })
      : super(OnBoardState()) {
    on<onUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(onUpdateOnBoardingUserEvent event,
      Emitter<OnBoardState> emitter) {

    updateOnboardingStateStreamUseCase.call().listen((event) async {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(OnBoardState().copyWith(status: OnBoardStatus.error));
        } else {
          emitter(OnBoardState().copyWith(status: OnBoardStatus.error));
        }
      },
          ifRight: (r) {
              emitter(OnBoardState().copyWith(
                  status: OnBoardStatus.loaded,
                  isFirstTime: false,
                  isAuthenticated: false
              ));

          });
    });
  }


// This function is called whenever the text field changes

}
