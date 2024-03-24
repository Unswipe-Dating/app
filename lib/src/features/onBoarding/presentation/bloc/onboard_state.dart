part of 'onboarding_bloc.dart';

enum OnBoardStatus { initial, loading, loaded, error }

class OnBoardState extends Equatable {
  final OnBoardStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;

  const OnBoardState({
    this.status = OnBoardStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,

  });


  OnBoardState copyWith({
    OnBoardStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
  }) {
    return OnBoardState(
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

