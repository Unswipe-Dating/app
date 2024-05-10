import 'package:equatable/equatable.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_list.dart';

import '../../data/model/response_profile_swipe.dart';

enum ProfileSwipeStatus { initial, fetchedToken, loading, loaded, error }

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