import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';
part 'onboarding_state.g.dart';

enum OnBoardingStatus  {
  none,
  init,
  otp,
  contact,
  images,
  profile,
  update,
  matchRequested,

}

@immutable
abstract class OnBoardingState {
  const OnBoardingState();

  OnBoardingStatus? get onBoardingEntity;

}

abstract class OnBoardedState
    implements
        Built<OnBoardedState, OnBoardedStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  OnBoardedState._();

  factory OnBoardedState(
      [void Function(OnBoardedStateBuilder) updates]) =
  _$OnBoardedState;
}

abstract class NotOnBoardedState
    implements
        Built<NotOnBoardedState, NotOnBoardedStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity => null;

  NotOnBoardedState._();

  factory NotOnBoardedState(
      [void Function(NotOnBoardedStateBuilder) updates]) =
  _$NotOnBoardedState;
}

abstract class AuthenticatedStateOnBoarded
    implements
        Built<AuthenticatedStateOnBoarded, AuthenticatedStateOnBoardedBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  AuthenticatedStateOnBoarded._();

  factory AuthenticatedStateOnBoarded(
      [void Function(AuthenticatedStateOnBoardedBuilder) updates]) =
  _$AuthenticatedStateOnBoarded;
}

abstract class ListBlockedState
    implements
        Built<ListBlockedState, ListBlockedStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  ListBlockedState._();

  factory ListBlockedState(
      [void Function(ListBlockedStateBuilder) updates]) =
  _$ListBlockedState;
}

abstract class ImageUploadedState
    implements
        Built<ImageUploadedState, ImageUploadedStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  ImageUploadedState._();

  factory ImageUploadedState(
      [void Function(ImageUploadedStateBuilder) updates]) =
  _$ImageUploadedState;
}

abstract class ProfileUpdateState
    implements
        Built<ProfileUpdateState, ProfileUpdateStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  ProfileUpdateState._();

  factory ProfileUpdateState(
      [void Function(ProfileUpdateStateBuilder) updates]) =
  _$ProfileUpdateState;
}

abstract class ProfileUpdatedState
    implements
        Built<ProfileUpdatedState, ProfileUpdatedStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  ProfileUpdatedState._();

  factory ProfileUpdatedState(
      [void Function(ProfileUpdatedStateBuilder) updates]) =
  _$ProfileUpdatedState;
}

abstract class ProfileMatchRequestState
    implements
        Built<ProfileMatchRequestState, ProfileMatchRequestStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingStatus? get onBoardingEntity;

  ProfileMatchRequestState._();

  factory ProfileMatchRequestState(
      [void Function(ProfileMatchRequestStateBuilder) updates]) =
  _$ProfileMatchRequestState;
}


