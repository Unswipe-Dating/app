import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/domain/usecases/request_otp_use_case.dart';
import 'package:unswipe/src/features/login/domain/usecases/verify_otp_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../../data/api_response.dart' as api_response;
import '../../../../../data/api_response.dart';
import '../../../onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import '../../../onBoarding/domain/usecases/get_onboarding_state_stream_use_case.dart';
import '../../../onBoarding/presentation/bloc/onboarding_bloc.dart';
import '../../domain/usecases/update_login_state_stream_usecase.dart';


part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LogInEvent, LoginState> {
  final UpdateOnboardingStateStreamUseCase updateOnboardingStateStreamUseCase;
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  String otpId = "";


  // final
  // List of splash
  late StreamSubscription _subscription;
  late StreamSubscription _subscriptionOnBoarding;


  LoginBloc({
    required this.updateUserStateStreamUseCase,
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase,
    required this.updateOnboardingStateStreamUseCase

  })
      : super(const LoginState()) {
    on<onOtpRequested>(_onOtpRequested);
    on<onOtpResendRequested>(_onOtpResendRequested);
    on<onOtpVerificationRequest>(_onOtpVerified);





  }

  _onOtpResendRequested(onOtpResendRequested event,
      Emitter<LoginState> emitter) async{

    LoginStatus status = LoginStatus.loadingResend;

    emitter(state.copyWith(status: status, token: status.index));

    requestOtpUseCase.perform((response)  {
      final responseData = response?.val;
      if (responseData == null) {
        status = LoginStatus.error;
      } else {
        if (responseData is api_response.Failure) {
          status = LoginStatus.error;
        } else if (responseData is api_response.Success) {
          status = LoginStatus.loadedResend;
          otpId = (responseData as api_response.Success).data;

        }
      }
    },
            (e) {
          status = LoginStatus.error;
        },
            (){

        },
        event.params

    );

    await Future.delayed(const Duration(seconds: 2), () {
    });
    emitter(state.copyWith(status: status, token: status.index));


  }

  _onOtpRequested(onOtpRequested event,
      Emitter<LoginState> emitter) async{

    LoginStatus status = LoginStatus.loadingOTP;

    emitter(state.copyWith(status: status, token: status.index));

     requestOtpUseCase.perform((response)  {
        final responseData = response?.val;
        if (responseData == null) {
          status = LoginStatus.error;
        } else {
          if (responseData is api_response.Failure) {
            status = LoginStatus.error;
          } else if (responseData is api_response.Success) {
            status = LoginStatus.loadedOtp;
            otpId = (responseData as api_response.Success).data;
          }
        }
      },
      (e) {
        status = LoginStatus.error;
        },
      (){

      },
      event.params

    );

     await Future.delayed(const Duration(seconds: 2), () {
        });
    emitter(state.copyWith(status: status, token: status.index));


  }



  _onLoginSuccess(onLoginSuccess event,
      Emitter<LoginState> emitter, LoginStatus status) async{


    _subscription = updateUserStateStreamUseCase.call(event.token).listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          status = LoginStatus.error;
        } else {
          status = LoginStatus.error;
        }
      },
          ifRight: (r) {
        status = LoginStatus.loaded;


          });
    });

  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _subscriptionOnBoarding.cancel();
    return super.close();
  }


// This function is called whenever the text field changes


  _onOtpVerified(onOtpVerificationRequest event, Emitter<LoginState> emitter) async {


    LoginStatus status = LoginStatus.loadingVerification;
    String token = "";

    emitter(state.copyWith(status: status, token: status.index));

    verifyOtpUseCase.perform((response)  {
      final responseData = response?.val;
      if (responseData == null) {
        status = LoginStatus.error;
      } else {
        if (responseData is api_response.Failure) {
          status = LoginStatus.error;
        } else if (responseData is api_response.Success) {
          status = LoginStatus.verified;
          token = (responseData as api_response.Success).data;


        }
      }
    },
            (e) {
          status = LoginStatus.error;
        },
            (){

        },
        OtpParams(phone: event.params.phone,
            id: event.params.id,
            otp:event.params.otp,
            otpOrderId: otpId)

    );

    await Future.delayed(const Duration(seconds: 2), () {
    });

    await _onLoginSuccess(onLoginSuccess(token), emitter, status);
    await _onUpdatingOnBoardingEvent(emitter, status);
    emitter(state.copyWith(status: status, token: status.index));

  }

  _onUpdatingOnBoardingEvent(
      Emitter<LoginState> emitter, LoginStatus status) async{

    _subscriptionOnBoarding = updateOnboardingStateStreamUseCase.call(OnBoardingStatus.profile).listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          status = LoginStatus.error;
        } else {
          status = LoginStatus.error;

        }
      },
          ifRight: (r) {
            status = LoginStatus.loaded;

          }

      );
    });
  }


}
