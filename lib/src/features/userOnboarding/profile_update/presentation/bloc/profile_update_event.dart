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
  OnUpdateOnBoardingUserEvent();
}

class OnRequestApiCall extends UpdateProfileEvent {
  final UpdateProfileParams params;
  final String id;
  final String token;
  OnRequestApiCall(this.params, this.token, this.id);
}

