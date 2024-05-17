import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/usecases/create_user_use_case.dart';

import '../../../../../../../data/api_response.dart' as api_response;
import '../../../../../../data/api_response.dart';
import '../../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../../image_upload/presentation/widgets/multi_image_picker_files/image_file.dart';
import '../../data/models/update_profile_param_and_response.dart';
part 'profile_update_event.dart';
part 'profile_update_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  // List of splash

  UpdateProfileBloc({
    required this.updateOnboardingStateStreamUseCase,
    required this.getAuthStateStreamUseCase,
    required this.updateProfileUseCase,
  })
      : super(UpdateProfileState()) {
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);
    on<OnUpdateProfileRequested>(_onStartUpdateProfile);
    on<OnRequestApiCall>(_onStartUpdateProfileApi);
  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<UpdateProfileState> emitter) async{

    emitter(state.copyWith(status: UpdateProfileStatus.loading));

    await Future.delayed(const Duration(seconds: 3));
    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(OnBoardingStatus.profile), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: UpdateProfileStatus.error);
        } else {
          return state.copyWith(status: UpdateProfileStatus.error);
        }
      },
          ifRight: (r) {
            return state.copyWith(status: UpdateProfileStatus.loaded);}
      );

    }, onError: (error, stacktrace) {
      return state.copyWith(status: UpdateProfileStatus.error);

    });

  }

  _onStartUpdateProfileApi(OnRequestApiCall event,
      Emitter<UpdateProfileState> emitter) async {
    UpdateProfileParams params = UpdateProfileParams().getUpdatedParams(event.params);
    params.id = event.id;
    params.userId = event.id;

    Stream<GetUpsertUserResponse> stream =
    await updateProfileUseCase.buildUseCaseStream(event.token,
        params);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.Success) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: UpdateProfileStatus.loading);
      } else {
        return state.copyWith(status: UpdateProfileStatus.error);
      }
    });
  }


  _onStartUpdateProfile(OnUpdateProfileRequested event,
      Emitter<UpdateProfileState> emitter) async {

    emitter(state.copyWith(
        status: UpdateProfileStatus.loading));

    await emitter.forEach(getAuthStateStreamUseCase.call(), onData: (response) {
      return response.fold(
          ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: UpdateProfileStatus.error);

            } else {
              return state.copyWith(status: UpdateProfileStatus.error);

            }
          },
          ifRight: (r) {

            if(r.userAndToken?.token != null && r.userAndToken?.id != null)  {
              add(OnRequestApiCall(event.params,
                  r.userAndToken!.token,
                  r.userAndToken!.id)
              );
              return state.copyWith(status: UpdateProfileStatus.loading);

            }else {
              return state.copyWith(status: UpdateProfileStatus.error);
            }

          }
      );
    },
    );

  }




// This function is called whenever the text field changes


}
