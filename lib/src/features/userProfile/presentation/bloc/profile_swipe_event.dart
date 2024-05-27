part of 'profile_swipe_bloc.dart';

abstract class ProfileSwipeEvent {
  const ProfileSwipeEvent();
}

class OnProfileSwipesSuccess extends ProfileSwipeEvent {
  OnProfileSwipesSuccess();
}

class OnProfileSwipeRequested extends ProfileSwipeEvent {
  final int route;
  OnProfileSwipeRequested(this.route);
}

class OnGetRequestedProfile extends ProfileSwipeEvent {
  final String id;
  final String token;

  OnGetRequestedProfile(
      this.token,
      this.id,
      );}

class OnUpdateOnBoardingUserEvent extends ProfileSwipeEvent {
  OnUpdateOnBoardingUserEvent();
}

class OnInitiateSubjects extends ProfileSwipeEvent {
  OnInitiateSubjects();
}

class OnInitiateRejectSubject extends ProfileSwipeEvent {
  OnInitiateRejectSubject();
}

class OnInitiateAcceptSubject extends ProfileSwipeEvent {
  OnInitiateAcceptSubject();
}

class OnInitiateCreateSubject extends ProfileSwipeEvent {
  OnInitiateCreateSubject();
}

class OnInitiateMatchSubject extends ProfileSwipeEvent {
  OnInitiateMatchSubject();
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

  final String matchId;

  OnCreateRequest(
      this.matchId,
  );
}

class OnAcceptRequest extends ProfileSwipeEvent {

  final String matchId;

  OnAcceptRequest(
      this.matchId,
      );
}

class OnRejectRequest extends ProfileSwipeEvent {
  final String matchId;

  OnRejectRequest(
      this.matchId,
      );
}
