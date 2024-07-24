part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  error,
  errorNetwork,
  errorAuth,
  errorTimeOut,
  loadingOTP,
  loadedOtp,
  loadingResend,
  loadedResend,
  loadingVerification,
  loadingSignup,
  verified,
  loaded,
  loadedChat,
  loadedExpiryTimer,
  loadingTimer
}
enum ErrorType {
  none,
  sendOtp,
  verifyOtp,
  signup,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final ErrorType errorType;
  final bool isOtpLoaded;
  final OnBoardingStatus onBoardingStatus;
  final String? profileMatchDuration;
  final ChatPageParams? chatParams;

  const LoginState({
    this.isOtpLoaded = false,
    this.status = LoginStatus.initial,
    this.errorType = ErrorType.none,
    this.onBoardingStatus = OnBoardingStatus.contact,
    this.profileMatchDuration,
    this.chatParams,
  });


  LoginState copyWith({
    bool? isOtpLoaded,
    LoginStatus? status,
    ErrorType? errorType,
    int? token,
    OnBoardingStatus? onBoardingStatus,
    String? profileMatchDuration,
    ChatPageParams? chatParams,
  }) {
    return LoginState(
      isOtpLoaded: isOtpLoaded?? this.isOtpLoaded,
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
        onBoardingStatus: onBoardingStatus ?? this.onBoardingStatus,
      profileMatchDuration: profileMatchDuration ?? this.profileMatchDuration,
        chatParams: chatParams ?? this.chatParams
    );
  }

  @override
  List<Object?> get props => [
    isOtpLoaded,
    status,
    errorType,
    onBoardingStatus,
    profileMatchDuration,
    chatParams,
  ];
}

