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
  final OnBoardingStatus onBoardingStatus;

  const LoginState({
    this.status = LoginStatus.initial,
    this.onBoardingStatus = OnBoardingStatus.contact,

  });


  LoginState copyWith({
    LoginStatus? status,
    int? token,
    OnBoardingStatus? onBoardingStatus,
  }) {
    return LoginState(
      status: status ?? this.status,
      onBoardingStatus: onBoardingStatus ?? this.onBoardingStatus,

    );
  }

  @override
  List<Object?> get props => [
    status,
    onBoardingStatus,
  ];
}

