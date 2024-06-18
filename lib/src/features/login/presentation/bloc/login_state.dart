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
  final ChatPageParams? chatParams;

  const LoginState({
    this.status = LoginStatus.initial,
    this.onBoardingStatus = OnBoardingStatus.contact,
    this.profileMatchDuration,
    this.chatParams,

  });


  LoginState copyWith({
    LoginStatus? status,
    int? token,
    OnBoardingStatus? onBoardingStatus,
    String? profileMatchDuration,
    ChatPageParams? chatParams,
  }) {
    return LoginState(
      status: status ?? this.status,
      onBoardingStatus: onBoardingStatus ?? this.onBoardingStatus,
      profileMatchDuration: profileMatchDuration ?? this.profileMatchDuration,
        chatParams: chatParams ?? this.chatParams
    );
  }

  @override
  List<Object?> get props => [
    status,
    onBoardingStatus,
    profileMatchDuration,
    chatParams,
  ];
}

