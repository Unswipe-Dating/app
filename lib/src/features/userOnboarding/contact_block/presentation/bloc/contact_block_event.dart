part of 'contact_bloc.dart';

abstract class ContactBlockEvent {
  const ContactBlockEvent();
}

class OnBlockContactsSuccess extends ContactBlockEvent {

  OnBlockContactsSuccess();
}

class OnContactBlockRequested extends ContactBlockEvent {
  final BlockContactDataParams params;

  OnContactBlockRequested(this.params);
}


class OnUpdateOnBoardingUserEvent extends ContactBlockEvent {
  bool isUnAuthorized = false;
  OnUpdateOnBoardingUserEvent({required this.isUnAuthorized});
}

class OnRequestApiCall extends ContactBlockEvent {
  final BlockContactDataParams params;
  final String id;
  final String token;
  OnRequestApiCall(this.params, this.token, this.id);
}

