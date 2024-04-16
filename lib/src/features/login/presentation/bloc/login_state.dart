part of 'login_bloc.dart';

enum LoginStatus { initial,
  error,
  loadingOTP,
  loadedOtp,
  loadingResend,
  loadedResend,
  loadingVerification,
  verified,
  loaded
}

class LoginState extends Equatable {
  final LoginStatus status;
  final int token;

  const LoginState({
    this.status = LoginStatus.initial,
    this.token = 0,

  });


  LoginState copyWith({
    LoginStatus? status,
    int? token
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token==null ? this.token: token>this.token ? token: this.token,
    );
  }

  @override
  List<Object?> get props => [
    status,
    token,
  ];
}

