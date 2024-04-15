part of 'login_bloc.dart';

enum LoginStatus { initial, loadingOTP, loadedOtp, loadingResend, loadedResend,  loaded, error }

class LoginState extends Equatable {
  final LoginStatus status;
  final String token;

  const LoginState({
    this.status = LoginStatus.initial,
    this.token = ""

  });


  LoginState copyWith({
    LoginStatus? status,
    String? token
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
    status,
    token,
  ];
}

