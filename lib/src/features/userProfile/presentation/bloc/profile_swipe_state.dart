import 'package:equatable/equatable.dart';

import '../../data/model/get_profile/response_profile_swipe.dart';

enum ProfileSwipeStatus { initial,
  fetchedToken,
  loading,
  loaded,
  loadedCreate,
  loadedReject,
  loadedAccept,
  loadedSkip,
  error,
  errorSwipe
}

class ProfileSwipeState extends Equatable {
  final ProfileSwipeStatus status;
  final ResponseProfileSwipe? responseProfileSwipe;

  const ProfileSwipeState({
    this.status = ProfileSwipeStatus.initial,
    this.responseProfileSwipe,

  });


  ProfileSwipeState copyWith({
    ProfileSwipeStatus? status,
    final ResponseProfileSwipe? responseProfileSwipe,
  }) {
    return ProfileSwipeState(
      status: status ?? this.status,
      responseProfileSwipe: responseProfileSwipe ?? this.responseProfileSwipe,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseProfileSwipe,
  ];
}