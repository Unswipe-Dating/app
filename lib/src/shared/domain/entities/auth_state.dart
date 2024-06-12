import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';
import 'package:unswipe/src/core/utils/constant/user_and_token_entity.dart';

part 'auth_state.g.dart';

@immutable
abstract class AuthenticationState {
  const AuthenticationState();

  UserAndTokenEntity? get userAndToken;

}

abstract class AuthenticatedState
    implements
        Built<AuthenticatedState, AuthenticatedStateBuilder>,
        AuthenticationState {
  @override
  UserAndTokenEntity get userAndToken;

  AuthenticatedState._();

  factory AuthenticatedState(
          [void Function(AuthenticatedStateBuilder) updates]) =
      _$AuthenticatedState;
}

abstract class UnauthenticatedState
    implements
        Built<UnauthenticatedState, UnauthenticatedStateBuilder>,
        AuthenticationState {
  @override
  UserAndTokenEntity? get userAndToken => null;

  UnauthenticatedState._();

  factory UnauthenticatedState(
          [void Function(UnauthenticatedStateBuilder) updates]) =
      _$UnauthenticatedState;
}
