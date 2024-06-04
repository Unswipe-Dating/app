import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/request_otp.dart';
import 'package:unswipe/src/features/login/data/models/signupOrLogin/signup_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/domain/usecases/request_otp_use_case.dart';
import 'package:unswipe/src/features/login/domain/usecases/signup_login_usecase.dart';
import 'package:unswipe/src/features/login/domain/usecases/verify_otp_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../../data/api_response.dart' as api_response;
import '../../../../../data/api_response.dart';
import '../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../splash/data/datasources/model/response_meta.dart';
import '../../../splash/domain/usecases/meta_usecase.dart';
import '../../../userProfile/data/model/create_request/response_profile_request.dart';
import '../../domain/usecases/update_login_state_stream_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LogInEvent, LoginState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final SignUpUseCase signUpUseCase;
  final MetaUseCase metaUseCase;


  String otpId = "";

  LoginBloc({required this.updateUserStateStreamUseCase,
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase,
    required this.signUpUseCase,
    required this.updateOnboardingStateStreamUseCase,
    required this.metaUseCase,

  })
      : super(const LoginState()) {
    on<OnOtpRequested>(_onOtpRequested);
    on<OnOtpResendRequested>(_onOtpResendRequested);
    on<OnOtpVerificationRequest>(_onOtpVerified);
    on<OnSignupRequest>(_onSignUp);
    on<OnUpdateOnBoardingUserEvent>(_onUpdatingOnBoardingEvent);
    on<OnLoginSuccess>(_onLoginSuccess);
    on<OnGetMetaEvent>(_onGettingMetaEvent);
    on<onStartChatIntent>(_onStartChatIntent);



  }

  _onUpdatingOnBoardingEvent(OnUpdateOnBoardingUserEvent event,
      Emitter<LoginState> emitter) async{

    OnBoardingStatus onBoardingStatus = OnBoardingStatus.contact;
    if(event.profileId != null) {
      onBoardingStatus = OnBoardingStatus.profile;
    }

    await emitter.forEach(
        updateOnboardingStateStreamUseCase
            .call(onBoardingStatus), onData: (event) {
      return event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          return state.copyWith(status: LoginStatus.error);
        } else {
          return state.copyWith(status: LoginStatus.error);
        }
      },
          ifRight: (r) {
            return state.copyWith(status: LoginStatus.loaded,
                onBoardingStatus: onBoardingStatus);
      }
      );

    }, onError: (error, stacktrace) {
      return state.copyWith(status: LoginStatus.error);

    });

  }


  _onOtpResendRequested(OnOtpResendRequested event,
      Emitter<LoginState> emitter) async {
    emitter(state.copyWith(
        status: LoginStatus.loadingResend,
        token: LoginStatus.loadingResend.index));

    Stream<GetOtpUseCaseResponse> stream =
    await requestOtpUseCase.buildUseCaseStream(event.params);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.Success) {
        otpId = (((responseData as api_response.Success).data) as OtpResponse)
            .requestOTP
            .orderId;
        return state.copyWith(
            status: LoginStatus.loadedResend);
      } else {
        return state.copyWith(status: LoginStatus.error);
      }
    });
  }


  _onOtpRequested(OnOtpRequested event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(
        status: LoginStatus.loadingOTP, token: LoginStatus.loadingOTP.index));

    Stream<GetOtpUseCaseResponse> stream =
    await requestOtpUseCase.buildUseCaseStream(event.params);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.Success) {
        otpId = (((responseData as api_response.Success).data) as OtpResponse)
            .requestOTP
            .orderId;
        return state.copyWith(
            status: LoginStatus.loadedOtp);
      } else {
        return state.copyWith(status: LoginStatus.error);
      }
    });
  }

  _onLoginSuccess(OnLoginSuccess event, Emitter<LoginState> emitter) async {
    LoginStatus status = LoginStatus.verified;
        updateUserStateStreamUseCase.call(event.token,
            event.id, event.userId).listen((
            event) {
          event.fold(
              ifLeft: (l) {
                if (l is CancelTokenFailure) {} else {}
              },
              ifRight: (r) {});
        });

    return status;
  }

  _onSignUp(OnSignupRequest event, Emitter<LoginState> emitter) async {

    Stream<SignUpUseCaseResponse> stream =
    await signUpUseCase.buildUseCaseStream(OtpParams(
        phone: event.params.phone,
        id: event.params.id
    ));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.Success) {
        var token =
            (((responseData as api_response.Success).data) as SignUpResponse).signup
                .accessToken;
        var profile = (((responseData as api_response.Success).data) as SignUpResponse).signup
            .user.profileId;
        var firebaseCustomToken = (((responseData as api_response.Success).data) as SignUpResponse).signup
            .user.firebaseCustomToken;

        add(OnLoginSuccess(token, event.params.id, profile));
        add(OnUpdateOnBoardingUserEvent(profileId: profile));

        return state.copyWith(status: LoginStatus.verified);

      } else {
        return state.copyWith(status: LoginStatus.error);
      }
    });
  }

  _onOtpVerified(OnOtpVerificationRequest event,
      Emitter<LoginState> emitter) async {

    emitter(state.copyWith(status: LoginStatus.loadingVerification));

    Stream<VerifyOtpUseCaseResponse> stream =
    await verifyOtpUseCase.buildUseCaseStream(OtpParams(
        phone: event.params.phone,
        id: event.params.id,
        otp: event.params.otp,
        otpOrderId: otpId,
        fcmRegisterationToken: event.params.fcmRegisterationToken
    ));

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.Success) {
        var token =
            (((responseData as api_response.Success).data) as VerifyOtpResponse)
                .validateOTP
                .accessToken ?? "";
        add(OnSignupRequest(event.params));
        return state.copyWith(status: LoginStatus.verified);

      } else {
        return state.copyWith(status: LoginStatus.error);
      }
    });
  }

  _onGettingMetaEvent(
      OnGetMetaEvent event, Emitter<LoginState> emitter) async {

    Stream<GetMetaUseCaseResponse> stream =
    await metaUseCase.buildUseCaseStream(
        event.token);

    await emitter.forEach(stream, onData: (response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.OperationFailure) {
        return state.copyWith(status: LoginStatus.error);
      } else if (responseData is api_response.Success) {
        var res = (((responseData as api_response.Success).data) as ResponseMeta);
        if(res.getConfig.timeLeftForExpiry != null) {
          return state.copyWith(status: LoginStatus.loadedExpiryTimer,
              profileMatchDuration: res.getConfig.timeLeftForExpiry
          );
        } else if (res.getConfig.status == "MATCHED"){
          if(res.getConfig.chat != null && res.getConfig.request != null) {
            // if(res.getConfig.chat?.status == "ACTIVE") {
            //   add(onStartChatIntent(res.getConfig.request));
            // } else {
            //   return state.copyWith(status: LoginStatus.loaded,);
            // }
            add(onStartChatIntent(res.getConfig.request));


          } else {
            return state.copyWith(status: LoginStatus.error);
          }
        } else {
          return state.copyWith(status: LoginStatus.loaded,
          );
        }
        return state.copyWith(status: LoginStatus.loadingTimer,);

      } else {
        return state.copyWith(status: LoginStatus.error);
      }
    });
  }

  _onStartChatIntent(
      onStartChatIntent event, Emitter<LoginState> emitter) async {
    var roomId =  await FirebaseChatCore.instance.createRoom(User(id:
    event.request?.requesteeProfileId ?? ""));
    emitter.call(state.copyWith(status: LoginStatus.loadedChat,
      chatId: roomId,)
    );
  }



}
