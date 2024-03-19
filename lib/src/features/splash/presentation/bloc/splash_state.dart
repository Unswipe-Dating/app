part of 'splash_bloc.dart';

abstract class SplashState {
  const SplashState();
}

class NyTimesInitial extends SplashState {}

// --------------------Start Get Articles States-------------------- //

// Loading Get Ny Times State
class LoadingGetSplashState extends SplashState {}

// Error On Getting Ny Times State
class ErrorGetSplashState extends SplashState {
  final String errorMsg;

  ErrorGetSplashState(this.errorMsg);
}

// Success Get Ny Times State
class SuccessGetSplashState extends SplashState {

  SuccessGetSplashState();
}
