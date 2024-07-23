import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dart_either/dart_either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart';
import 'package:unswipe/src/core/app_error.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/create_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../../../../../../data/api_response.dart' as api_response;
import '../../../../../../data/api_response.dart';
import '../../../../../shared/domain/usecases/get_auth_state_stream_use_case.dart';
import '../../../../login/domain/usecases/update_login_state_stream_usecase.dart';
import '../../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../../onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import '../../../../settings/domain/usecases/get_settings_profile_usecase.dart';
import '../../../../userProfile/data/model/get_profile/response_profile_swipe.dart';
import '../../domain/usecases/create_user_use_case.dart';
import '../../domain/usecases/update_user_use_case.dart';

part 'profile_update_event.dart';

part 'profile_update_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;
  final GetAuthStateStreamUseCase getAuthStateStreamUseCase;
  final CreateProfileUseCase createProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetSettingsProfileUseCase getSettingsProfileUseCase;

  String token = "";
  String id = "";
  String? userId;

  // List of splash

  UpdateProfileBloc(
      {required this.updateOnboardingStateStreamUseCase,
      required this.getAuthStateStreamUseCase,
      required this.createProfileUseCase,
      required this.updateProfileUseCase,
      required this.updateUserStateStreamUseCase,
      required this.getSettingsProfileUseCase})
      : super(UpdateProfileState()) {
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);
    on<OnGetTokenEvent>(_onGetAuthToken);
    on<OnRequestApiCallUpdate>(_onUpdateProfileApi);
    on<OnRequestApiCallCreate>(_onCreateProfileApi);
    on<OnUpdateUserState>(_onProfileCreateSuccess);
    on<OnStartGettingProfile>(_onStartSettingProfileUseCase);
    on<OnGetUserProfile>(_onGetUserProfile);
  }

  _onProfileCreateSuccess(
      OnUpdateUserState event, Emitter<UpdateProfileState> emitter) async {
    await FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: event.response.name,
        id: event.id ?? "",
        imageUrl: '',
      ),
    );
    Stream<Either<AppError, void>> stream = updateUserStateStreamUseCase.call(
        event.token, event.id, event.response.id);

    emitter.forEach(stream, onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: UpdateProfileStatus.error);
        } else {
          return state.copyWith(status: UpdateProfileStatus.error);
        }
      }, ifRight: (r) {
        add(OnUpdateOnBoardingUserEvent(isUnAuthorized: false));
        return state.copyWith(status: UpdateProfileStatus.loaded);
      });
    }, onError: (error, stacktrace) {
      return state.copyWith(status: UpdateProfileStatus.error);
    });
  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<UpdateProfileState> emitter) async {
    OnBoardingStatus status = OnBoardingStatus.profile;
    if (event.isUnAuthorized) {
      status = OnBoardingStatus.init;
    }
    await emitter.forEach(updateOnboardingStateStreamUseCase.call(status),
        onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: UpdateProfileStatus.error);
        } else {
          return state.copyWith(status: UpdateProfileStatus.error);
        }
      }, ifRight: (r) {
        if (status == OnBoardingStatus.init) {
          return state.copyWith(status: UpdateProfileStatus.errorAuth);
        }
        return state.copyWith(status: UpdateProfileStatus.loaded);
      });
    }, onError: (error, stacktrace) {
      return state.copyWith(status: UpdateProfileStatus.error);
    });
  }

  _onUpdateProfileApi(
      OnRequestApiCallUpdate event, Emitter<UpdateProfileState> emitter) async {
    UpdateProfileParams params =
        UpdateProfileParams.getUpdatedParams(event.params);
    params.id = id;
    params.userId = id;

    Stream<GetUpdateUserResponse> stream =
        await updateProfileUseCase.buildUseCaseStream(token, params);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        add(OnUpdateOnBoardingUserEvent(isUnAuthorized: true));
        return state.copyWith(status: UpdateProfileStatus.loading);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: UpdateProfileStatus.errorAuth);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.Success) {
        add(OnUpdateOnBoardingUserEvent(isUnAuthorized: false));
        return state.copyWith(status: UpdateProfileStatus.loading);
      } else {
        return state.copyWith(status: UpdateProfileStatus.error);
      }
    });
  }

  _onCreateProfileApi(
      OnRequestApiCallCreate event, Emitter<UpdateProfileState> emitter) async {
    UpdateProfileParams params =
        UpdateProfileParams.getUpdatedParams(event.params);
    params.id = id;
    params.userId = id;
    UpsertProfile profile;

    Stream<GetCreateUserResponse> stream =
        await createProfileUseCase.buildUseCaseStream(token, params);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        return state.copyWith(status: UpdateProfileStatus.errorAuth);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: UpdateProfileStatus.errorTimeOut);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.Success) {
        profile = (((responseData as api_response.Success).data)
                as CreateProfileResponse)
            .createProfile;
        add(OnUpdateUserState(profile, token, id));
        return state.copyWith(status: UpdateProfileStatus.loading);
      } else {
        return state.copyWith(status: UpdateProfileStatus.error);
      }
    });
  }

  _onGetAuthToken(
      OnGetTokenEvent event, Emitter<UpdateProfileState> emitter) async {
    emitter(state.copyWith(status: UpdateProfileStatus.loading));

    await emitter.forEach(
      getAuthStateStreamUseCase.call(),
      onData: (response) {
        return response.fold(ifLeft: (l) {
          if (l is CancelTokenFailure) {
            return state.copyWith(status: UpdateProfileStatus.error);
          } else {
            return state.copyWith(status: UpdateProfileStatus.error);
          }
        }, ifRight: (r) {
          if (r.userAndToken?.token != null && r.userAndToken?.id != null) {
            token = r.userAndToken!.token;
            id = r.userAndToken!.id;
            userId = r.userAndToken!.userId;
            return state.copyWith(status: UpdateProfileStatus.loading);
          } else {
            return state.copyWith(status: UpdateProfileStatus.error);
          }
        });
      },
    );
  }

  _onStartSettingProfileUseCase(
      OnStartGettingProfile event, Emitter<UpdateProfileState> emitter) async {
    emitter(state.copyWith(status: UpdateProfileStatus.loading));

    await emitter.forEach(
      getAuthStateStreamUseCase.call(),
      onData: (response) {
        return response.fold(ifLeft: (l) {
          if (l is CancelTokenFailure) {
            return state.copyWith(status: UpdateProfileStatus.error);
          } else {
            return state.copyWith(status: UpdateProfileStatus.error);
          }
        }, ifRight: (r) {
          if (r.userAndToken?.token != null && r.userAndToken?.id != null) {
            token = r.userAndToken!.token;
            id = r.userAndToken!.id;
            userId = r.userAndToken!.userId;
            add(OnGetUserProfile(r.userAndToken!.token, r.userAndToken!.id));
            return state.copyWith(status: UpdateProfileStatus.loading);
          } else {
            return state.copyWith(status: UpdateProfileStatus.error);
          }
        });
      },
    );
  }

  _onGetUserProfile(
      OnGetUserProfile event, Emitter<UpdateProfileState> emitter) async {
    Stream<GetSettingsProfileUseCaseResponse> stream =
        await getSettingsProfileUseCase.buildUseCaseStream(
            event.token, event.id);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.AuthorizationFailure) {
        return state.copyWith(status: UpdateProfileStatus.errorAuth);
      } else if (responseData is api_response.TimeOutFailure) {
        return state.copyWith(status: UpdateProfileStatus.errorTimeOut);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: UpdateProfileStatus.error);
      } else if (responseData is api_response.Success) {
        var profile = (((responseData as api_response.Success).data)
                as ResponseProfileSwipe)
            .userProfile;
        return state.copyWith(
            status: UpdateProfileStatus.loadedProfile,
            responseProfileList: profile);
      } else {
        return state.copyWith(status: UpdateProfileStatus.error);
      }
    });
  }

// This function is called whenever the text field changes
}
