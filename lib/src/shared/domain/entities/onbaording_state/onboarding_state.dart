import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';
part 'onboarding_state.g.dart';

@immutable
abstract class OnBoardingState {
  const OnBoardingState();

  bool? get onBoardingEntity;

}

abstract class OnBoardedState
    implements
        Built<OnBoardedState, OnBoardedStateBuilder>,
        OnBoardingState {
  @override
  bool? get onBoardingEntity;

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
  bool? get onBoardingEntity => null;

  NotOnBoardedState._();

  factory NotOnBoardedState(
      [void Function(NotOnBoardedStateBuilder) updates]) =
  _$NotOnBoardedState;
}
