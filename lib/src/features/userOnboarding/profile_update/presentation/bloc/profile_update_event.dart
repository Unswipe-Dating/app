part of 'profile_update_bloc.dart';




abstract class UpdateProfileEvent {
  const UpdateProfileEvent();
}

class OnBlockContactsSuccess extends UpdateProfileEvent {

  OnBlockContactsSuccess();
}

class OnGetTokenEvent extends UpdateProfileEvent {

  OnGetTokenEvent();
}


class OnUpdateOnBoardingUserEvent extends UpdateProfileEvent {
  bool isUnAuthorized = false;
  OnUpdateOnBoardingUserEvent({required this.isUnAuthorized});
}

class OnRequestApiCallUpdate extends UpdateProfileEvent {
  final UpdateProfileParams params;
  OnRequestApiCallUpdate(this.params);
}

class OnUpdateUserState extends UpdateProfileEvent {
  final String id;
  final String token;
  final UpsertProfile response;
  OnUpdateUserState(this.response, this.token, this.id);
}

class OnStartGettingProfile extends UpdateProfileEvent {
  OnStartGettingProfile();
}

class OnGetUserProfile extends UpdateProfileEvent {
  final String id;
  final String token;
  OnGetUserProfile(this.token, this.id);
}



class OnRequestApiCallCreate extends UpdateProfileEvent {
  final UpdateProfileParams params;
  OnRequestApiCallCreate(this.params);
}
