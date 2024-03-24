import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/shared/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../core/network/error/failures.dart';


part 'onboarding_event.dart';
part 'onboard_state.dart';


class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;

  // List of splash
  late StreamSubscription _subscription;

  OnBoardingBloc({
    required this.updateOnboardingStateStreamUseCase
  })
      : super(OnBoardState()) {
    on<onUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(onUpdateOnBoardingUserEvent event,
      Emitter<OnBoardState> emitter) async{

    _subscription = updateOnboardingStateStreamUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(state.copyWith(status: OnBoardStatus.error));
        } else {
          emitter(state.copyWith(status: OnBoardStatus.error));
        }
      },
          ifRight: (r) {
              emitter(state.copyWith(
                  status: OnBoardStatus.loaded,
                  isFirstTime: false,
                  isAuthenticated: false
              ));

           });
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


// This function is called whenever the text field changes

}
