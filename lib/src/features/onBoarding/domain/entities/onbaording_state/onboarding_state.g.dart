// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OnBoardedState extends OnBoardedState {
  @override
  final bool? onBoardingEntity;

  factory _$OnBoardedState([void Function(OnBoardedStateBuilder)? updates]) =>
      (new OnBoardedStateBuilder()..update(updates))._build();

  _$OnBoardedState._({this.onBoardingEntity}) : super._();

  @override
  OnBoardedState rebuild(void Function(OnBoardedStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OnBoardedStateBuilder toBuilder() =>
      new OnBoardedStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnBoardedState &&
        onBoardingEntity == other.onBoardingEntity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, onBoardingEntity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OnBoardedState')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class OnBoardedStateBuilder
    implements Builder<OnBoardedState, OnBoardedStateBuilder> {
  _$OnBoardedState? _$v;

  bool? _onBoardingEntity;
  bool? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(bool? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  OnBoardedStateBuilder();

  OnBoardedStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnBoardedState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OnBoardedState;
  }

  @override
  void update(void Function(OnBoardedStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OnBoardedState build() => _build();

  _$OnBoardedState _build() {
    final _$result =
        _$v ?? new _$OnBoardedState._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

class _$NotOnBoardedState extends NotOnBoardedState {
  factory _$NotOnBoardedState(
          [void Function(NotOnBoardedStateBuilder)? updates]) =>
      (new NotOnBoardedStateBuilder()..update(updates))._build();

  _$NotOnBoardedState._() : super._();

  @override
  NotOnBoardedState rebuild(void Function(NotOnBoardedStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotOnBoardedStateBuilder toBuilder() =>
      new NotOnBoardedStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotOnBoardedState;
  }

  @override
  int get hashCode {
    return 223107129;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'NotOnBoardedState').toString();
  }
}

class NotOnBoardedStateBuilder
    implements Builder<NotOnBoardedState, NotOnBoardedStateBuilder> {
  _$NotOnBoardedState? _$v;

  NotOnBoardedStateBuilder();

  @override
  void replace(NotOnBoardedState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NotOnBoardedState;
  }

  @override
  void update(void Function(NotOnBoardedStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotOnBoardedState build() => _build();

  _$NotOnBoardedState _build() {
    final _$result = _$v ?? new _$NotOnBoardedState._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
