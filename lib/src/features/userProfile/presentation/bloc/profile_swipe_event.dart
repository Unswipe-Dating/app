part of 'profile_swipe_bloc.dart';

abstract class ProfileSwipeEvent {
  const ProfileSwipeEvent();
}

class OnProfileSwipesSuccess extends ProfileSwipeEvent {
  OnProfileSwipesSuccess();
}

class OnProfileSwipeRequested extends ProfileSwipeEvent {
  OnProfileSwipeRequested();
}

class OnUpdateOnBoardingUserEvent extends ProfileSwipeEvent {
  OnUpdateOnBoardingUserEvent();
}

class OnRequestApiCall extends ProfileSwipeEvent {
  final String id;
  final String token;

  OnRequestApiCall(
    this.token,
    this.id,
  );
}

class OnCreateRequest extends ProfileSwipeEvent {
  final String id;
  final String token;
  final String matchId;

  OnCreateRequest(
    this.token,
    this.id,
      this.matchId,
  );
}

class OnRejectRequest extends ProfileSwipeEvent {
  final String id;
  final String token;
  final String matchId;

  OnRejectRequest(
      this.token,
      this.id,
      this.matchId,
      );
}
