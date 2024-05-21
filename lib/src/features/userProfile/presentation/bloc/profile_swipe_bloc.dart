import 'package:bloc/bloc.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_accept_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_get_requested_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_reject_usecase.dart';
import 'package:unswipe/src/shared/domain/entities/auth_state.dart';

import '../../../../../../data/api_response.dart' as api_response;

import '../../../../../../data/api_response.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';
import '../../domain/repository/profile_swipe_repository.dart';
import '../../domain/usecase/profile_get_usecase.dart';
import 'profile_swipe_state.dart';
part 'profile_swipe_event.dart';

class ProfileSwipeBloc extends Bloc<ProfileSwipeEvent, ProfileSwipeState> {
  final ProfileGetUseCase profileSwipeUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final ProfileAcceptUseCase profileAcceptUseCase;
  final ProfileRejectUseCase profileRejectUseCase;
  final ProfileGetRequestedUseCase profileGetRequestedUseCase;
  String token = "";
  String id = "";
  String userId = "";

  // List of splash

  ProfileSwipeBloc({
    required this.profileSwipeUseCase,
    required this.getAuthStateStreamUseCase,
    required this.profileAcceptUseCase,
    required this.profileRejectUseCase,
    required this.profileGetRequestedUseCase,
  })
      : super(const ProfileSwipeState()) {
    on<OnGetRequestedProfile>(_onStartRequestedProfileApi);
    on<OnProfileSwipeRequested>(_onStartProfileSwipe);
    on<OnRequestApiCall>(_onStartProfileApi);
    on<OnCreateRequest>(_onCreateRequest);
    on<OnRejectRequest>(_onRejectRequest);





  }

  _onCreateRequest(OnCreateRequest event,
      Emitter<ProfileSwipeState> emitter) async {


    Stream<GetProfileAcceptUseCaseResponse> stream =
    await profileAcceptUseCase.buildUseCaseStream(
        token,
        ProfileSwipeParams( userId: userId));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data) as ResponseProfileSwipe);
        return state.copyWith(status: ProfileSwipeStatus.loaded,
            responseProfileSwipe: res);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.error);
      }
    });
  }

  _onRejectRequest(OnRejectRequest event,
      Emitter<ProfileSwipeState> emitter) async {

    Stream<GetProfileRejectUseCaseResponse> stream =
    await profileRejectUseCase.buildUseCaseStream(
        token,
        ProfileSwipeParams( userId: userId));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data) as ResponseProfileSwipe);
        return state.copyWith(status: ProfileSwipeStatus.loaded,
            responseProfileSwipe: res);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.error);
      }
    });
  }


  _onStartProfileApi(OnRequestApiCall event,
      Emitter<ProfileSwipeState> emitter) async {


    Stream<GetProfileSwipeUseCaseResponse> stream =
    await profileSwipeUseCase.buildUseCaseStream(
        event.token,
        ProfileSwipeParams( userId: event.id));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data) as ResponseProfileSwipe);
        return state.copyWith(status: ProfileSwipeStatus.loaded,
            responseProfileSwipe: res);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.error);
      }
    });
  }

  _onStartRequestedProfileApi(OnGetRequestedProfile event,
      Emitter<ProfileSwipeState> emitter) async {


    Stream<GetProfileSwipeUseCaseResponse> stream =
    await profileSwipeUseCase.buildUseCaseStream(
        event.token,
        ProfileSwipeParams( userId: event.id));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data) as ResponseProfileSwipe);
        return state.copyWith(status: ProfileSwipeStatus.loaded,
            responseProfileSwipe: res);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.error);
      }
    });
  }


  _onStartProfileSwipe(OnProfileSwipeRequested event,
      Emitter<ProfileSwipeState> emitter) async {

     emitter(state.copyWith(
        status: ProfileSwipeStatus.loading));

    await emitter.forEach(getAuthStateStreamUseCase.call(), onData: (response) {
      return response.fold(
          ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: ProfileSwipeStatus.error);

            } else {
              return state.copyWith(status: ProfileSwipeStatus.error);

            }
          },
          ifRight: (r) {

            if(r.userAndToken?.token != null
                && r.userAndToken?.id != null)  {
              if(event.route == 0) {
                add(OnRequestApiCall(
                  r.userAndToken!.token,
                  r.userAndToken!.id)
              );
              } else {
                add(OnGetRequestedProfile( r.userAndToken!.token,
                    r.userAndToken!.id));
              }
              token = r.userAndToken!.token;
              id = r.userAndToken!.id;
              userId = r.userAndToken!.userId!;

              return state.copyWith(status: ProfileSwipeStatus.loading);

            }else {
              return state.copyWith(status: ProfileSwipeStatus.error);
            }

          }
      );
    },
    );

  }


// This function is called whenever the text field changes


}
