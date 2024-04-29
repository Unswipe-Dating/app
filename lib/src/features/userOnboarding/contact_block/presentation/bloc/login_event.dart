part of 'login_bloc.dart';

abstract class LogInEvent {
  const LogInEvent();
}

class onLoginSuccess extends LogInEvent {
  final String token;

  onLoginSuccess(this.token);
}

class onOtpRequested extends LogInEvent {
  final OtpParams params;

  onOtpRequested(this.params);
}

class onOtpResendRequested extends LogInEvent {
  final OtpParams params;

  onOtpResendRequested(this.params);
}

class onOtpVerificationRequest extends LogInEvent {
  final OtpParams params;

  onOtpVerificationRequest(this.params);
}
