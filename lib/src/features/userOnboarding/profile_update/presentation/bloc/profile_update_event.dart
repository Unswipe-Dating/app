part of 'profile_update_bloc.dart';




abstract class UpdateProfileEvent {
  const UpdateProfileEvent();
}

class OnBlockContactsSuccess extends UpdateProfileEvent {

  OnBlockContactsSuccess();
}

class OnUpdateProfileRequested extends UpdateProfileEvent {
  final UpdateProfileParams params;

  OnUpdateProfileRequested(this.params);
}


class OnUpdateOnBoardingUserEvent extends UpdateProfileEvent {
  bool isUnAuthorized = false;
  OnUpdateOnBoardingUserEvent({required this.isUnAuthorized});
}

class OnRequestApiCallUpdate extends UpdateProfileEvent {
  final UpdateProfileParams params;
  final String id;
  final String token;
  OnRequestApiCallUpdate(this.params, this.token, this.id);
}

class OnUpdateUserState extends UpdateProfileEvent {
  final String id;
  final String token;
  final UpsertProfile response;
  OnUpdateUserState(this.response, this.token, this.id);
}

class OnStartGettingProfile extends UpdateProfileEvent {
  final String id;
  final String token;
  OnStartGettingProfile(this.token, this.id);
}

class OnGetUserProfile extends UpdateProfileEvent {
  final String id;
  final String token;
  OnGetUserProfile(this.token, this.id);
}



class OnRequestApiCallCreate extends UpdateProfileEvent {
  final UpdateProfileParams params;
  final String id;
  final String token;
  OnRequestApiCallCreate(this.params, this.token, this.id);
}
