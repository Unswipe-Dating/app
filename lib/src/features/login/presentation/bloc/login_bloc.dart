import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/login/data/models/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/domain/usecases/request_otp_use_case.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';

import '../../../../../data/api_response.dart' as api_response;
import '../../../../../data/api_response.dart';
import '../../domain/usecases/update_login_state_stream_usecase.dart';


part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LogInEvent, LoginState> {
  final UpdateUserStateStreamUseCase updateUserStateStreamUseCase;
  final RequestOtpUseCase requestOtpUseCase;

  // final
  // List of splash
  late StreamSubscription _subscription;

  LoginBloc({
    required this.updateUserStateStreamUseCase,
    required this.requestOtpUseCase
  })
      : super(LoginState()) {
    on<onLoginSuccess>(_onLoginSuccess);
    on<onOtpRequested>(_onOtpRequested);



  }

  _onOtpRequested(onOtpRequested event,
      Emitter<LoginState> emitter) async{

    emitter(state.copyWith(status: LoginStatus.loadingOTP));
    LoginStatus status = state.status;
    await requestOtpUseCase.perform(
      (response) async {
        final responseData = response?.val;
        if (responseData == null) {
          status = LoginStatus.error;
          // emitter(state.copyWith(status: LoginStatus.error));
        } else {
          if (responseData is api_response.Failure) {
            // emitter(state.copyWith(status: LoginStatus.error));
          } else if (responseData is api_response.Success) {
            // emitter(state.copyWith(status: LoginStatus.loadedOtp));
          }
        }
      },
      (e) async {
        // emitter(state.copyWith(status: LoginStatus.error));
        },
      (){

      },
      OtpParams(phone: "", id: "")

    ).whenComplete(() {
      emitter(state.copyWith(status: LoginStatus.loadedOtp));
    });

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
                  token: "token"
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

}
