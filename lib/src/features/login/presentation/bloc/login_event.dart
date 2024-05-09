part of 'login_bloc.dart';

abstract class LogInEvent {
  const LogInEvent();
}

class OnLoginSuccess extends LogInEvent {
  final String token;
  final String id;

  OnLoginSuccess(this.token, this.id);
}

class OnOtpRequested extends LogInEvent {
  final OtpParams params;

  OnOtpRequested(this.params);
}

class OnOtpResendRequested extends LogInEvent {
  final OtpParams params;

  OnOtpResendRequested(this.params);
}

class OnOtpVerificationRequest extends LogInEvent {
  final OtpParams params;

  OnOtpVerificationRequest(this.params);
}
