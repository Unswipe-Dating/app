import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:unswipe/src/chat/chat.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_accept_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_create_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_get_requested_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_reject_usecase.dart';
import 'package:unswipe/src/features/userProfile/domain/usecase/profile_skip_usecase.dart';
import 'package:unswipe/src/shared/domain/entities/auth_state.dart';

import '../../../../../../data/api_response.dart' as api_response;

import '../../../../../../data/api_response.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../data/model/create_request/response_profile_request.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';
import '../../domain/repository/profile_swipe_repository.dart';
import '../../domain/usecase/profile_get_usecase.dart';
import 'profile_swipe_state.dart';

part 'profile_swipe_event.dart';

class ProfileSwipeBloc extends Bloc<ProfileSwipeEvent, ProfileSwipeState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final ProfileGetUseCase profileSwipeUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final ProfileCreateUseCase profileCreateUseCase;
  final ProfileRejectUseCase profileRejectUseCase;
  final ProfileGetRequestedUseCase profileGetRequestedUseCase;
  final ProfileAcceptUseCase profileAcceptUseCase;
  final ProfileSkipUseCase profileSkipUseCase;


  String token = "";
  String id = "";
  String userId = "";

  // List of splash

  ProfileSwipeBloc({
    required this.profileSwipeUseCase,
    required this.getAuthStateStreamUseCase,
    required this.profileCreateUseCase,
    required this.profileRejectUseCase,
    required this.profileGetRequestedUseCase,
    required this.profileAcceptUseCase,
    required this.profileSkipUseCase,
    required this.updateOnboardingStateStreamUseCase,
  }) : super(const ProfileSwipeState()) {
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);
    on<OnGetRequestedProfile>(_onStartRequestedProfileApi);
    on<OnProfileSwipeRequested>(_onStartProfileSwipe);
    on<OnRequestApiCall>(_onStartProfileApi);
    on<OnCreateRequest>(_onCreateRequest);
    on<OnAcceptRequest>(_onAcceptRequest);
    on<OnRejectRequest>(_onRejectRequest);
    on<OnSkipRequest>(_onSkipRequest);
    on<OnInitiateSubjects>(setUpProfileSwipeApi);
    on<OnInitiateRejectSubject>(setUpRejectApi);
    on<OnInitiateSkipSubject>(setUpSkipApi);
    on<OnInitiateCreateSubject>(setUpCreateApi);
    on<OnInitiateAcceptSubject>(setUpAcceptApi);
    on<OnInitiateMatchSubject>(setUpMatchApi);
    on<onStartChatIntent>(_onStartChatIntent);

  }


  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(
        updateOnboardingStateStreamUseCase.call(OnBoardingStatus.init),
        onData: (event) {
          return event.fold(ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: ProfileSwipeStatus.error);
            } else {
              return state.copyWith(status: ProfileSwipeStatus.error);
            }
          }, ifRight: (r) {
            return state.copyWith(status: ProfileSwipeStatus.errorAuth);
          });
        }, onError: (error, stacktrace) {
      return state.copyWith(status: ProfileSwipeStatus.error);
    });
  }

  setUpMatchApi(
      OnInitiateMatchSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileGetRequestedUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: ProfileSwipeStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorTimeOut);
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

  setUpCreateApi(
      OnInitiateCreateSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileCreateUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: ProfileSwipeStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorTimeOut);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.Success) {
        var response = responseData as ResponseProfileRequest;
        return state.copyWith(
            status: ProfileSwipeStatus.loadedCreate, request: response);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
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
          } else if (responseData is api_response.AuthorizationFailure) {
            add(OnUpdateOnBoardingUserEvent());
            return state.copyWith(status: ProfileSwipeStatus.loading);
          } else if (responseData is api_response.TimeOutFailure) {
            return state.copyWith(status: ProfileSwipeStatus.errorTimeOut);
          } else if (responseData is api_response.OperationFailure) {
            return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
          } else if (responseData is api_response.Success) {
            var res =
            (((responseData as api_response.Success).data) as ResponseProfileRequest);
            if(res.matchRequest != null) {
              add(onStartChatIntent(res.matchRequest!, id));
              return state.copyWith(status: ProfileSwipeStatus.loadedAccept);
              } else {
              return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
            }
          } else {
            return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
          }
        });
  }

  _onStartChatIntent(
      onStartChatIntent event, Emitter<ProfileSwipeState> emitter) async {
    var roomId =  await FirebaseChatCore.instance.createRoom(types.User(id:
    event.request.requesteeUserId == event.userId ? event.request.userId: event.request.requesteeUserId));
    emitter.call(state.copyWith(status: ProfileSwipeStatus.loadedChat,
      chatParams: ChatPageParams(room: roomId, request: event.request),
    ));
  }


  setUpRejectApi(
      OnInitiateRejectSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileRejectUseCase.controller.stream,
        onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: ProfileSwipeStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorTimeOut);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      } else if (responseData is api_response.Success) {
        state.responseProfileSwipe?.browseProfiles?.profiles.removeAt(0);
        return state.copyWith(
            status: ProfileSwipeStatus.loadedReject);
      } else {
        return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
      }
    });
  }

  setUpSkipApi(
      OnInitiateSkipSubject event, Emitter<ProfileSwipeState> emitter) async {
    await emitter.forEach(profileSkipUseCase.controller.stream,
        onData: (response) {
          final responseData = response.val;
          if (responseData is api_response.Failure) {
            return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
          } else if (responseData is api_response.AuthorizationFailure) {
            add(OnUpdateOnBoardingUserEvent());
            return state.copyWith(status: ProfileSwipeStatus.loading);
          } else if (responseData is api_response.TimeOutFailure) {
            return state.copyWith(status: ProfileSwipeStatus.errorTimeOut);
          } else if (responseData is api_response.OperationFailure) {
            return state.copyWith(status: ProfileSwipeStatus.errorSwipe);
          } else if (responseData is api_response.Success) {
            state.responseProfileSwipe?.browseProfiles?.profiles.removeAt(0);
            return state.copyWith(
                status: ProfileSwipeStatus.loadedSkip);
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
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnUpdateOnBoardingUserEvent());
        return state.copyWith(status: ProfileSwipeStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: ProfileSwipeStatus.errorTimeOut);
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
    await profileCreateUseCase.buildUseCaseStream(
        token, ProfileSwipeParams(userId: userId, matchUserId: event.matchId));
  }

  _onAcceptRequest(
      OnAcceptRequest event, Emitter<ProfileSwipeState> emitter) async {
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

  _onSkipRequest(
      OnSkipRequest event, Emitter<ProfileSwipeState> emitter) async {
    emitter(state.copyWith(status: ProfileSwipeStatus.loading));
    await profileSkipUseCase.buildUseCaseStream(
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
            token = r.userAndToken!.token;
            id = r.userAndToken!.id;
            userId = r.userAndToken!.userId!;
            if (event.route == 0) {
              add(OnRequestApiCall());
            } else {
              add(OnGetRequestedProfile());
            }


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
    profileCreateUseCase.controller.close();
    profileRejectUseCase.controller.close();
    profileGetRequestedUseCase.controller.close();
    return super.close();
  }

// This function is called whenever the text field changes
}
