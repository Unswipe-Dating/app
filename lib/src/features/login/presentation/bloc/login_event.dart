part of 'login_bloc.dart';

abstract class LogInEvent {
  const LogInEvent();
}

class onLoginSuccess extends LogInEvent {
  final String token;

  onLoginSuccess(this.token);
}
