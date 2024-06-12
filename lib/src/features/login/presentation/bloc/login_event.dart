part of 'login_bloc.dart';

abstract class LogInEvent {
  const LogInEvent();
}

class OnLoginSuccess extends LogInEvent {
  final String token;
  final String id;
  final String? userId;

  OnLoginSuccess(this.token, this.id, this.userId);
}

class OnOtpRequested extends LogInEvent {
  final OtpParams params;

  OnOtpRequested(this.params);
}

class OnOtpResendRequested extends LogInEvent {
  final OtpParams params;

  OnOtpResendRequested(this.params);
}

class OnUpdateOnBoardingUserEvent extends LogInEvent {
  String? profileId;
  OnUpdateOnBoardingUserEvent({this.profileId});
}

class OnGetMetaEvent extends LogInEvent {
  final String token;
  final String id;
  final String? userId;
  final String? fcmCustomToken;
  OnGetMetaEvent({required this.token,
    required this.id,
    required this.userId,
    required this.fcmCustomToken});
}

class onStartChatIntent extends LogInEvent {
  ResponseProfileCreateRequest? request;

  onStartChatIntent(this.request);
}

class OnOtpVerificationRequest extends LogInEvent {
  final OtpParams params;

  OnOtpVerificationRequest(this.params);
}

class OnSignupRequest extends LogInEvent {
  final OtpParams params;

  OnSignupRequest(this.params);
}
