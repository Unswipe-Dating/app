part of 'login_bloc.dart';

enum LoginStatus { initial,
  error,
  errorAuth,
  errorTimeOut,
  loadingOTP,
  loadedOtp,
  loadingResend,
  loadedResend,
  loadingVerification,
  verified,
  loaded,
  loadedChat,
  loadedExpiryTimer,
  loadingTimer
}

class LoginState extends Equatable {
  final LoginStatus status;
  final OnBoardingStatus onBoardingStatus;
  final String? profileMatchDuration;
  final types.Room? chatId;

  const LoginState({
    this.status = LoginStatus.initial,
    this.onBoardingStatus = OnBoardingStatus.contact,
    this.profileMatchDuration,
    this.chatId,

  });


  LoginState copyWith({
    LoginStatus? status,
    int? token,
    OnBoardingStatus? onBoardingStatus,
    String? profileMatchDuration,
    types.Room? chatId,
  }) {
    return LoginState(
      status: status ?? this.status,
      onBoardingStatus: onBoardingStatus ?? this.onBoardingStatus,
      profileMatchDuration: profileMatchDuration ?? this.profileMatchDuration,
        chatId: chatId ?? this.chatId
    );
  }

  @override
  List<Object?> get props => [
    status,
    onBoardingStatus,
    profileMatchDuration,
    chatId
  ];
}

