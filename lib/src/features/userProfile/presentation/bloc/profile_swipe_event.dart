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


  OnGetRequestedProfile(

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

class OnInitiateSkipSubject extends ProfileSwipeEvent {
  OnInitiateSkipSubject();
}


class OnInitiateAcceptSubject extends ProfileSwipeEvent {
  OnInitiateAcceptSubject();
}

class OnInitiateCreateSubject extends ProfileSwipeEvent {
  OnInitiateCreateSubject();
}

class onStartChatIntent extends ProfileSwipeEvent {
  ResponseProfileCreateRequest request;
  String userId;

  onStartChatIntent(this.request, this.userId);
}

class OnInitiateMatchSubject extends ProfileSwipeEvent {
  OnInitiateMatchSubject();
}


class OnRequestApiCall extends ProfileSwipeEvent {

  OnRequestApiCall(
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

class OnSkipRequest extends ProfileSwipeEvent {
  final String matchId;

  OnSkipRequest(
      this.matchId,
      );
}
