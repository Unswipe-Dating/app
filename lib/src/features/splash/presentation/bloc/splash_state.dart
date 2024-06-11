part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, loaded, error, errorAuth, errorTimeOut, loadedChat }

class SplashState extends Equatable {
  final SplashStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;
  final bool isBoardedAhead;
  final bool isUserJourneyComplete;
  final bool isImageUploaded;
  final bool isContactsBlocked;
  final bool isProfileUpdated;
  final bool isProfileMatchRequested;
  final String profileMatchDuration;
  final Room? loadChat;


  const SplashState({
    this.status = SplashStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,
    this.isBoardedAhead = false,
    this.isUserJourneyComplete = false,
    this.isImageUploaded = false,
    this.isContactsBlocked = false,
    this.isProfileUpdated = false,
    this.isProfileMatchRequested = false,
    this.profileMatchDuration = "",
    this.loadChat

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
    bool? isProfileMatchRequested,
    String? profileMatchDuration,
    Room? loadChat,

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
      isProfileMatchRequested: isProfileMatchRequested ?? this.isProfileMatchRequested,
      profileMatchDuration: profileMatchDuration ?? this.profileMatchDuration,
      loadChat: loadChat ?? this.loadChat

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
    isProfileMatchRequested,
    profileMatchDuration,
    loadChat
  ];
}

