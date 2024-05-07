import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../data/api_response.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';



part 'contact_block_event.dart';
part 'contact_block_state.dart';


class ContactBloc extends Bloc<OnBoardingEvent, OnBoardState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;

  // List of splash

  ContactBloc({
    required this.updateOnboardingStateStreamUseCase
  })
      : super(OnBoardState()) {
    on<onUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(onUpdateOnBoardingUserEvent event,
      Emitter<OnBoardState> emitter) async{

    emitter(state.copyWith(status: OnBoardStatus.loading));

    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(OnBoardingStatus.images), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: OnBoardStatus.error);
        } else {
          return state.copyWith(status: OnBoardStatus.error);
        }
      },
      ifRight: (r) {
        return state.copyWith(status: OnBoardStatus.loaded);}
      );

    }, onError: (error, stacktrace) {
      return state.copyWith(status: OnBoardStatus.error);

    });

  }


// This function is called whenever the text field changes


}
