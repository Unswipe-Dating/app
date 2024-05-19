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

class OnOtpVerificationRequest extends LogInEvent {
  final OtpParams params;

  OnOtpVerificationRequest(this.params);
}

class OnSignupRequest extends LogInEvent {
  final OtpParams params;

  OnSignupRequest(this.params);
}
