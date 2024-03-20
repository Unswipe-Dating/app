part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, loaded, error }

class SplashState extends Equatable {
  final SplashStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;

  const SplashState({
    this.status = SplashStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,

  });


  SplashState copyWith({
    SplashStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
  }) {
    return SplashState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
  ];
}

