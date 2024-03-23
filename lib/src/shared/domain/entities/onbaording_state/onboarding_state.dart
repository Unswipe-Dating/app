import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';
import 'package:unswipe/src/core/utils/constant/on_boarding_token_entity.dart';
import 'package:unswipe/src/core/utils/constant/user_and_token_entity.dart';

part 'onboarding_state.g.dart';

@immutable
abstract class OnBoardingState {
  const OnBoardingState();

  OnBoardingTokenEntity? get onBoardingEntity;

}

abstract class OnBoardedState
    implements
        Built<OnBoardedState, OnBoardedStateBuilder>,
        OnBoardingState {
  @override
  OnBoardingTokenEntity get onBoardingEntity;

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
  OnBoardingTokenEntity? get onBoardingEntity => null;

  NotOnBoardedState._();

  factory NotOnBoardedState(
      [void Function(NotOnBoardedStateBuilder) updates]) =
  _$NotOnBoardedState;
}
