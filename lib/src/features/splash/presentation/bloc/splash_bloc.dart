import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/reset_user_token_state_stream_usecase.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';
import '../../../../../../data/api_response.dart' as api_response;
import 'package:unswipe/src/features/splash/domain/usecases/meta_usecase.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart';
import '../../../../../data/api_response.dart';
import '../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../userProfile/data/model/create_request/response_profile_request.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetOnboardingStateStreamUseCase onboardingStateStreamUseCase;
  final MetaUseCase metaUseCase;
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final ResetUserTokenStateStreamUseCase resetUserTokenStateStreamUseCase;
  StreamSubscription? subscription;

  SplashBloc({
    required this.onboardingStateStreamUseCase,
    required this.metaUseCase,
    required this.getAuthStateStreamUseCase,
    required this.updateOnboardingStateStreamUseCase,
    required this.resetUserTokenStateStreamUseCase,
  }) : super(const SplashState()) {
    on<onFirstTimeUserEvent>(_onGettingOnBoardingEvent);
    on<onGetMetaEvent>(_onGettingMetaEvent);
    on<onAuthenticatedUserEvent>(_onStartAuthCheck);
    on<onCheckChatIntent>(_onCheckChatIntent);
    on<onStartChatIntent>(_onStartChatIntent);
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);
    on<OnResetUserTokenEvent>(_onResetUserTokenEvent);


  }

  _onResetUserTokenEvent(OnResetUserTokenEvent event,
      Emitter<SplashState> emitter) async {
    await emitter.forEach(
        resetUserTokenStateStreamUseCase.call(),
        onData: (event) {
          return event.fold(ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: SplashStatus.error);
            } else {
              return state.copyWith(status: SplashStatus.error);
            }
          }, ifRight: (r) {
            add(OnUpdateOnBoardingUserEvent());
            return state.copyWith(status: SplashStatus.loading);
          });
        }, onError: (error, stacktrace) {
      return state.copyWith(status: SplashStatus.error);
    });
  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<SplashState> emitter) async {
    await emitter.forEach(
        updateOnboardingStateStreamUseCase.call(OnBoardingStatus.init),
        onData: (event) {
          return event.fold(ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: SplashStatus.error);
            } else {
              return state.copyWith(status: SplashStatus.error);
            }
          }, ifRight: (r) {
            return state.copyWith(status: SplashStatus.errorAuth);
          });
        }, onError: (error, stacktrace) {
      return state.copyWith(status: SplashStatus.error);
    });
  }

  _onStartAuthCheck(onAuthenticatedUserEvent event,
      Emitter<SplashState> emitter) async {

    emitter(state.copyWith(status: SplashStatus.loading));

    await emitter.forEach(getAuthStateStreamUseCase.call(), onData: (response) {
      return response.fold(
          ifLeft: (l) {
            if (l is CancelTokenFailure) {
              return state.copyWith(status: SplashStatus.error);
            } else {
              return state.copyWith(status: SplashStatus.error);
            }
          },
          ifRight: (r) {

            if(r.userAndToken?.token != null && r.userAndToken?.id != null)  {
              add(onGetMetaEvent(token: r.userAndToken!.token));
            }else {
              add(onFirstTimeUserEvent());
            }
            return state.copyWith(status: SplashStatus.loading);

          }
      );
    },
    );

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
        }  else if (r is ListBlockedState) {
          return state.copyWith(
            status: SplashStatus.loaded,
            isFirstTime: false,
            isAuthenticated: true,
            isBoardedAhead: true,
            isUserJourneyComplete: false,
            isContactsBlocked: true,
          );
        }  else if (r is ImageUploadedState) {
          return state.copyWith(
            status: SplashStatus.loaded,
            isFirstTime: false,
            isAuthenticated: true,
            isBoardedAhead: true,
            isUserJourneyComplete: false,
            isImageUploaded: true,
          );
        }

        else if (r is ProfileUpdateState) {
          return state.copyWith(
            status: SplashStatus.loaded,
            isFirstTime: false,
            isAuthenticated: true,
            isBoardedAhead: true,
            isUserJourneyComplete: false,
            isProfileUpdated: true,
          );
        }

        else {
            return state.copyWith(
                status: SplashStatus.loaded,
                isFirstTime: false,
                isAuthenticated: false,
                isBoardedAhead: true);

        }
      });
    });
  }

  _onGettingMetaEvent(
      onGetMetaEvent event, Emitter<SplashState> emitter) async {

    Stream<GetMetaUseCaseResponse> stream =
    await metaUseCase.buildUseCaseStream(
        event.token);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: SplashStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: SplashStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnResetUserTokenEvent());
        return state.copyWith(status: SplashStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: SplashStatus.errorTimeOut);
      } else if (responseData is api_response.Success) {
        var res =
        (((responseData as api_response.Success).data) as ResponseMeta);
        if (res.getConfig.status == "MATCHED") {
          if (res.getConfig.request != null) {
            add(onStartChatIntent(res.getConfig.request));
          } else {
            return state.copyWith(status: SplashStatus.error);
          }
        } else if (res.getConfig.status =="ACTIVE"
            && res.getConfig.timeLeftForExpiry != null) {
          return state.copyWith(status: SplashStatus.loaded,
              isFirstTime: false,
              isAuthenticated: true,
              isProfileMatchRequested: true,
              profileMatchDuration: res.getConfig.timeLeftForExpiry
          );
        } else {
          add(onFirstTimeUserEvent());
        }
        return state.copyWith(status: SplashStatus.loading,);

      } else {
        return state.copyWith(status: SplashStatus.error);
      }
    });
  }

  _onCheckChatIntent(
      onCheckChatIntent event, Emitter<SplashState> emitter) async {

    Stream<List<Room>> stream =
    FirebaseChatCore.instance.rooms();

    await emitter.forEach(stream, onData: (response) {
      final responseData = response;
      if (responseData.isEmpty) {
      add(onStartChatIntent(event.request));
      return state.copyWith(status: SplashStatus.loading,);
      } else  {
        return state.copyWith(status: SplashStatus.loaded,
          isFirstTime: false,
          isAuthenticated: true,
          loadChat: response.first,
        );
      }
    });
  }

  _onStartChatIntent(
      onStartChatIntent event, Emitter<SplashState> emitter) async {
    var roomId =  await FirebaseChatCore.instance.createRoom(User(id:
    event.request?.requesteeProfileId ?? ""));
    emitter.call(state.copyWith(status: SplashStatus.loadedChat,
    isFirstTime: false,
    isAuthenticated: true,
    loadChat: roomId,)
    );
  }

// Getting splash event

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
