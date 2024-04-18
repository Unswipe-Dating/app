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
import '../../domain/usecases/update_login_state_stream_usecase.dart';


part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LogInEvent, LoginState> {
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;


  // final
  // List of splash
  late StreamSubscription _subscription;

  LoginBloc({
    required this.updateUserStateStreamUseCase,
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase

  })
      : super(const LoginState()) {
    on<onLoginSuccess>(_onLoginSuccess);
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
        }
      }
    },
            (e) {
          status = LoginStatus.error;
        },
            (){

        },
        OtpParams(phone: "", id: "")

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
          }
        }
      },
      (e) {
        status = LoginStatus.error;
        },
      (){

      },
      OtpParams(phone: "", id: "")

    );

     await Future.delayed(const Duration(seconds: 2), () {
        });
    emitter(state.copyWith(status: status, token: status.index));


  }



  _onLoginSuccess(onLoginSuccess event,
      Emitter<LoginState> emitter) async{

    _subscription = updateUserStateStreamUseCase.call().listen((event) {
      event.fold(ifLeft: (l) {
        if (l is CancelTokenFailure) {
          emitter(state.copyWith(status: LoginStatus.error));
        } else {
          emitter(state.copyWith(status: LoginStatus.error));
        }
      },
          ifRight: (r) {
              emitter(state.copyWith(
                  status: LoginStatus.loaded,
                  token: 25
              ));

           });
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }


// This function is called whenever the text field changes


  _onOtpVerified(onOtpVerificationRequest event, Emitter<LoginState> emitter) async {


    LoginStatus status = LoginStatus.loadingVerification;

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
        }
      }
    },
            (e) {
          status = LoginStatus.error;
        },
            (){

        },
        OtpParams(phone: "", id: "", otp:"")

    );

    await Future.delayed(const Duration(seconds: 2), () {
    });

    await _onLoginSuccess(onLoginSuccess(""), emitter);
    emitter(state.copyWith(status: status, token: status.index));



  }
}
