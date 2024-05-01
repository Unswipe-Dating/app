import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/userOnboarding/domain/usecases/block_contact_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/domain/usecases/create_user_use_case.dart';

import '../../../../../../data/api_response.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../../domain/usecases/upload_images_use_case.dart';



part 'contact_block_event.dart';
part 'contact_block_state.dart';


class ContactBloc extends Bloc<OnBoardingEvent, OnBoardState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;

  // List of splash
  late StreamSubscription _subscription;

  ContactBloc({
    required this.updateOnboardingStateStreamUseCase
  })
      : super(OnBoardState()) {
    on<onUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);

  }

  _onUpdatingOnBoardingEvent(onUpdateOnBoardingUserEvent event,
      Emitter<OnBoardState> emitter) async{

    _subscription = updateOnboardingStateStreamUseCase.call(OnBoardingStatus.profile).listen((event) {
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

          }

      );
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


// This function is called whenever the text field changes


}
