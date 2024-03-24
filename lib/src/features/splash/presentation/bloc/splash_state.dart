part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, loaded, error }

class SplashState extends Equatable {
  final SplashStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;
  final bool isBoardedAhead;

  const SplashState({
    this.status = SplashStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,
    this.isBoardedAhead = false


  });


  SplashState copyWith({
    SplashStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
    bool? isBoardedAhead,
  }) {
    return SplashState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isBoardedAhead: isBoardedAhead ?? this.isBoardedAhead,

    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
  ];
}

