part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, loaded, error }

class SplashState extends Equatable {
  final SplashStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;
  final bool isBoardedAhead;
  final bool isUserJourneyComplete;
  final bool isImageUploaded;
  final bool isContactsBlocked;
  final bool isProfileUpdated;


  const SplashState({
    this.status = SplashStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,
    this.isBoardedAhead = false,
    this.isUserJourneyComplete = false,
    this.isImageUploaded = false,
    this.isContactsBlocked = false,
    this.isProfileUpdated = false

  });


  SplashState copyWith({
    SplashStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
    bool? isBoardedAhead,
    bool? isUserJourneyComplete,
    bool? isImageUploaded,
    bool? isContactsBlocked,
    bool? isProfileUpdated,

  }) {
    return SplashState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isBoardedAhead: isBoardedAhead ?? this.isBoardedAhead,
      isUserJourneyComplete: isUserJourneyComplete ?? this.isUserJourneyComplete,
      isImageUploaded: isImageUploaded ?? this.isImageUploaded,
      isContactsBlocked: isContactsBlocked ?? this.isContactsBlocked,
      isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
    isUserJourneyComplete,
    isImageUploaded,
    isContactsBlocked,
    isProfileUpdated,

  ];
}

