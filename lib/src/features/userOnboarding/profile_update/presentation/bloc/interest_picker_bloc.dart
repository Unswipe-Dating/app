import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../../../../../../data/api_response.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../../image_upload/presentation/widgets/multi_image_picker_files/image_file.dart';


class InterestPickerBloc extends Bloc<OnBoardingEvent, OnBoardState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;

  // List of splash

  InterestPickerBloc({
    required this.updateOnboardingStateStreamUseCase
  })
      : super(OnBoardState()) {
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<OnBoardState> emitter) async{

    emitter(state.copyWith(status: OnBoardStatus.loading));

    await Future.delayed(const Duration(seconds: 3));
    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(OnBoardingStatus.profile), onData: (event) {
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
