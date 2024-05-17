import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
import '../../domain/usecases/update_login_state_stream_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LogInEvent, LoginState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final SignUpUseCase signUpUseCase;

  String otpId = "";

  // final
  // List of splash
  StreamSubscription? subscription;
  StreamSubscription? subscriptionOnBoarding;

  LoginBloc({required this.updateUserStateStreamUseCase,
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase,
    required this.signUpUseCase,
    required this.updateOnboardingStateStreamUseCase})
      : super(const LoginState()) {
    on<OnOtpRequested>(_onOtpRequested);
    on<OnOtpResendRequested>(_onOtpResendRequested);
    on<OnOtpVerificationRequest>(_onOtpVerified);
    on<OnSignupRequest>(_onSignUp);

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

  Future<LoginStatus> _onLoginSuccess(OnLoginSuccess event) async {
    LoginStatus status = LoginStatus.verified;
    subscription =
        updateUserStateStreamUseCase.call(event.token,
            event.id).listen((
            event) {
          event.fold(
              ifLeft: (l) {
                if (l is CancelTokenFailure) {} else {}
              },
              ifRight: (r) {});
        });

    return status;
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    subscriptionOnBoarding?.cancel();
    return super.close();
  }

  _onSignUp(OnSignupRequest event, Emitter<LoginState> emitter) async {
    LoginStatus status = LoginStatus.loadingVerification;
    String token = "";
    String id = "";
    SignUpUserProfileResponse? profile;
    LoginState intermediateState = state;

    emitter(state.copyWith(status: status));

    Stream<SignUpUseCaseResponse> stream =
    await signUpUseCase.buildUseCaseStream(
        OtpParams(
            phone: event.params.phone,
            id: event.params.id
        )
    );

    stream.listen((response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        status = LoginStatus.error;
      } else if (responseData is api_response.OperationFailure) {
        status = LoginStatus.error;
      } else if (responseData is api_response.Success) {
        status = LoginStatus.verified;
        token =
            (((responseData as api_response.Success).data) as SignUpResponse).signup
                .accessToken;
        profile = (((responseData as api_response.Success).data) as SignUpResponse).signup
            .user.profile;

      } else {
        status = LoginStatus.error;
      }
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    if (status == LoginStatus.verified) {
      await _onLoginSuccess(OnLoginSuccess(token, event.params.id));
      intermediateState = await _onUpdatingOnBoardingEvent(profile);
      status = intermediateState.status;
    }
    emitter(state.copyWith(status: status,
        onBoardingStatus: intermediateState.onBoardingStatus));
  }

  _onOtpVerified(OnOtpVerificationRequest event,
      Emitter<LoginState> emitter) async {
    LoginStatus status = LoginStatus.loadingVerification;
    String token = "";

    emitter(state.copyWith(status: status, token: status.index));

    Stream<VerifyOtpUseCaseResponse> stream =
    await verifyOtpUseCase.buildUseCaseStream(OtpParams(
        phone: event.params.phone,
        id: event.params.id,
        otp: event.params.otp,
        otpOrderId: otpId));

    stream.listen((response) {
      final responseData = response.val;
      if (responseData is api_response.Failure) {
        status = LoginStatus.error;
      } else if (responseData is api_response.OperationFailure) {
        status = LoginStatus.error;
      } else if (responseData is api_response.Success) {
        status = LoginStatus.verified;
        token =
            (((responseData as api_response.Success).data) as VerifyOtpResponse)
                .validateOTP
                .accessToken;
      } else {
        status = LoginStatus.error;
      }
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    if (status == LoginStatus.verified) {
      add(OnSignupRequest(event.params));
    } else {
      emitter(state.copyWith(status: status));
    }
  }

  Future<LoginState> _onUpdatingOnBoardingEvent(SignUpUserProfileResponse? profile) async {
    LoginStatus status = LoginStatus.verified;
    OnBoardingStatus onBoardingStatus = OnBoardingStatus.contact;
    if(profile != null) {
      onBoardingStatus = OnBoardingStatus.profile;
    }
      subscriptionOnBoarding = updateOnboardingStateStreamUseCase
        .call(onBoardingStatus)
        .listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          status = LoginStatus.error;
        } else {
          status = LoginStatus.error;
        }
      }, ifRight: (r) {
        status = LoginStatus.loaded;
      });
    });

    await Future.delayed(const Duration(seconds: 2), () {});
    return LoginState(status: status, onBoardingStatus: onBoardingStatus);
  }
}
