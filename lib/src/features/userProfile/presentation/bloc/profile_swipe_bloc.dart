import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
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
  }) : super(const ProfileSwipeState()) {
    on<OnGetRequestedProfile>(_onStartRequestedProfileApi);
    on<OnProfileSwipeRequested>(_onStartProfileSwipe);
    on<OnRequestApiCall>(_onStartProfileApi);
    on<OnCreateRequest>(_onCreateRequest);
    on<OnRejectRequest>(_onRejectRequest);
    on<OnInitiateSubjects>(setUpProfileSwipeApi);
    on<OnInitiateRejectSubject>(setUpRejectApi);
    on<OnInitiateAcceptSubject>(setUpAcceptApi);
    on<OnInitiateMatchSubject>(setUpMatchApi);
  }

  setUpMatchApi(
      OnInitiateMatchSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileGetRequestedUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data)
            as ResponseProfileSwipe);
        return state.copyWith(
            status: ProfileSwipeStatus.loaded, responseProfileSwipe: res);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.error);
      }
    });
  }

  setUpAcceptApi(
      OnInitiateAcceptSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileAcceptUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.Success) {
        return state.copyWith(
            status: ProfileSwipeStatus.loadedCreate);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      }
    });
  }

  setUpRejectApi(
      OnInitiateRejectSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileRejectUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.Success) {
        return state.copyWith(
            status: ProfileSwipeStatus.loadedReject);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      }
    });
  }

  setUpProfileSwipeApi(
      OnInitiateSubjects event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileSwipeUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data)
            as ResponseProfileSwipe);
        return state.copyWith(
            status: ProfileSwipeStatus.loaded, responseProfileSwipe: res);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.error);
      }
    });
  }

  _onCreateRequest(
      OnCreateRequest event, Emitter<ProfileSwipeState> emitter) async {
    emitter(state.copyWith(status: ProfileSwipeStatus.loading));
    await profileAcceptUseCase.buildUseCaseStream(
        token, ProfileSwipeParams(userId: userId, matchUserId: event.matchId));
  }

  _onRejectRequest(
      OnRejectRequest event, Emitter<ProfileSwipeState> emitter) async {
    emitter(state.copyWith(status: ProfileSwipeStatus.loading));
    await profileRejectUseCase.buildUseCaseStream(
        token, ProfileSwipeParams(userId: userId, matchUserId: event.matchId));
  }

  _onStartProfileApi(
      OnRequestApiCall event, Emitter<ProfileSwipeState> emitter) async {
    emitter(state.copyWith(status: ProfileSwipeStatus.loading));
    await profileSwipeUseCase.buildUseCaseStream(
        token, ProfileSwipeParams(userId: id));
  }

  _onStartRequestedProfileApi(
      OnGetRequestedProfile event, Emitter<ProfileSwipeState> emitter) async {
    profileGetRequestedUseCase.buildUseCaseStream(
        token, ProfileSwipeParams(userId: id));
  }

  _onStartProfileSwipe(
      OnProfileSwipeRequested event, Emitter<ProfileSwipeState> emitter) async {
    emitter(state.copyWith(status: ProfileSwipeStatus.loading));

    await emitter.forEach(
      getAuthStateStreamUseCase.call(),
      onData: (response) {
        return response.fold(ifLeft: (l) {
          if (l is CancelTokenFailure) {
            return state.copyWith(status: ProfileSwipeStatus.error);
          } else {
            return state.copyWith(status: ProfileSwipeStatus.error);
          }
        }, ifRight: (r) {
          if (r.userAndToken?.token != null && r.userAndToken?.id != null) {
            if (event.route == 0) {
              token = r.userAndToken!.token;
              id = r.userAndToken!.id;
              userId = r.userAndToken!.userId!;
              add(OnRequestApiCall(r.userAndToken!.token, r.userAndToken!.id));
            } else {
              add(OnGetRequestedProfile(
                  r.userAndToken!.token, r.userAndToken!.id));
            }
            token = r.userAndToken!.token;
            id = r.userAndToken!.id;
            userId = r.userAndToken!.userId!;

            return state.copyWith(status: ProfileSwipeStatus.loading);
          } else {
            return state.copyWith(status: ProfileSwipeStatus.error);
          }
        });
      },
    );
  }

  @override
  Future<void> close() {
    profileSwipeUseCase.controller.close();
    profileAcceptUseCase.controller.close();
    profileRejectUseCase.controller.close();
    profileGetRequestedUseCase.controller.close();
    return super.close();
  }

// This function is called whenever the text field changes
}
