// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OnBoardedState extends OnBoardedState {
  @override
  final OnBoardingStatus? onBoardingEntity;

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

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
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

class _$AuthenticatedStateOnBoarded extends AuthenticatedStateOnBoarded {
  @override
  final OnBoardingStatus? onBoardingEntity;

  factory _$AuthenticatedStateOnBoarded(
          [void Function(AuthenticatedStateOnBoardedBuilder)? updates]) =>
      (new AuthenticatedStateOnBoardedBuilder()..update(updates))._build();

  _$AuthenticatedStateOnBoarded._({this.onBoardingEntity}) : super._();

  @override
  AuthenticatedStateOnBoarded rebuild(
          void Function(AuthenticatedStateOnBoardedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthenticatedStateOnBoardedBuilder toBuilder() =>
      new AuthenticatedStateOnBoardedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthenticatedStateOnBoarded &&
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
    return (newBuiltValueToStringHelper(r'AuthenticatedStateOnBoarded')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class AuthenticatedStateOnBoardedBuilder
    implements
        Builder<AuthenticatedStateOnBoarded,
            AuthenticatedStateOnBoardedBuilder> {
  _$AuthenticatedStateOnBoarded? _$v;

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  AuthenticatedStateOnBoardedBuilder();

  AuthenticatedStateOnBoardedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthenticatedStateOnBoarded other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthenticatedStateOnBoarded;
  }

  @override
  void update(void Function(AuthenticatedStateOnBoardedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthenticatedStateOnBoarded build() => _build();

  _$AuthenticatedStateOnBoarded _build() {
    final _$result = _$v ??
        new _$AuthenticatedStateOnBoarded._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

class _$ListBlockedState extends ListBlockedState {
  @override
  final OnBoardingStatus? onBoardingEntity;

  factory _$ListBlockedState(
          [void Function(ListBlockedStateBuilder)? updates]) =>
      (new ListBlockedStateBuilder()..update(updates))._build();

  _$ListBlockedState._({this.onBoardingEntity}) : super._();

  @override
  ListBlockedState rebuild(void Function(ListBlockedStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListBlockedStateBuilder toBuilder() =>
      new ListBlockedStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListBlockedState &&
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
    return (newBuiltValueToStringHelper(r'ListBlockedState')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class ListBlockedStateBuilder
    implements Builder<ListBlockedState, ListBlockedStateBuilder> {
  _$ListBlockedState? _$v;

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  ListBlockedStateBuilder();

  ListBlockedStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListBlockedState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ListBlockedState;
  }

  @override
  void update(void Function(ListBlockedStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListBlockedState build() => _build();

  _$ListBlockedState _build() {
    final _$result =
        _$v ?? new _$ListBlockedState._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

class _$ImageUploadedState extends ImageUploadedState {
  @override
  final OnBoardingStatus? onBoardingEntity;

  factory _$ImageUploadedState(
          [void Function(ImageUploadedStateBuilder)? updates]) =>
      (new ImageUploadedStateBuilder()..update(updates))._build();

  _$ImageUploadedState._({this.onBoardingEntity}) : super._();

  @override
  ImageUploadedState rebuild(
          void Function(ImageUploadedStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageUploadedStateBuilder toBuilder() =>
      new ImageUploadedStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageUploadedState &&
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
    return (newBuiltValueToStringHelper(r'ImageUploadedState')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class ImageUploadedStateBuilder
    implements Builder<ImageUploadedState, ImageUploadedStateBuilder> {
  _$ImageUploadedState? _$v;

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  ImageUploadedStateBuilder();

  ImageUploadedStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageUploadedState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImageUploadedState;
  }

  @override
  void update(void Function(ImageUploadedStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImageUploadedState build() => _build();

  _$ImageUploadedState _build() {
    final _$result =
        _$v ?? new _$ImageUploadedState._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

class _$ProfileUpdateState extends ProfileUpdateState {
  @override
  final OnBoardingStatus? onBoardingEntity;

  factory _$ProfileUpdateState(
          [void Function(ProfileUpdateStateBuilder)? updates]) =>
      (new ProfileUpdateStateBuilder()..update(updates))._build();

  _$ProfileUpdateState._({this.onBoardingEntity}) : super._();

  @override
  ProfileUpdateState rebuild(
          void Function(ProfileUpdateStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileUpdateStateBuilder toBuilder() =>
      new ProfileUpdateStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileUpdateState &&
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
    return (newBuiltValueToStringHelper(r'ProfileUpdateState')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class ProfileUpdateStateBuilder
    implements Builder<ProfileUpdateState, ProfileUpdateStateBuilder> {
  _$ProfileUpdateState? _$v;

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  ProfileUpdateStateBuilder();

  ProfileUpdateStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileUpdateState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileUpdateState;
  }

  @override
  void update(void Function(ProfileUpdateStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileUpdateState build() => _build();

  _$ProfileUpdateState _build() {
    final _$result =
        _$v ?? new _$ProfileUpdateState._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

class _$ProfileUpdatedState extends ProfileUpdatedState {
  @override
  final OnBoardingStatus? onBoardingEntity;

  factory _$ProfileUpdatedState(
          [void Function(ProfileUpdatedStateBuilder)? updates]) =>
      (new ProfileUpdatedStateBuilder()..update(updates))._build();

  _$ProfileUpdatedState._({this.onBoardingEntity}) : super._();

  @override
  ProfileUpdatedState rebuild(
          void Function(ProfileUpdatedStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileUpdatedStateBuilder toBuilder() =>
      new ProfileUpdatedStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileUpdatedState &&
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
    return (newBuiltValueToStringHelper(r'ProfileUpdatedState')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class ProfileUpdatedStateBuilder
    implements Builder<ProfileUpdatedState, ProfileUpdatedStateBuilder> {
  _$ProfileUpdatedState? _$v;

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  ProfileUpdatedStateBuilder();

  ProfileUpdatedStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileUpdatedState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileUpdatedState;
  }

  @override
  void update(void Function(ProfileUpdatedStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileUpdatedState build() => _build();

  _$ProfileUpdatedState _build() {
    final _$result =
        _$v ?? new _$ProfileUpdatedState._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

class _$ProfileMatchRequestState extends ProfileMatchRequestState {
  @override
  final OnBoardingStatus? onBoardingEntity;

  factory _$ProfileMatchRequestState(
          [void Function(ProfileMatchRequestStateBuilder)? updates]) =>
      (new ProfileMatchRequestStateBuilder()..update(updates))._build();

  _$ProfileMatchRequestState._({this.onBoardingEntity}) : super._();

  @override
  ProfileMatchRequestState rebuild(
          void Function(ProfileMatchRequestStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileMatchRequestStateBuilder toBuilder() =>
      new ProfileMatchRequestStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileMatchRequestState &&
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
    return (newBuiltValueToStringHelper(r'ProfileMatchRequestState')
          ..add('onBoardingEntity', onBoardingEntity))
        .toString();
  }
}

class ProfileMatchRequestStateBuilder
    implements
        Builder<ProfileMatchRequestState, ProfileMatchRequestStateBuilder> {
  _$ProfileMatchRequestState? _$v;

  OnBoardingStatus? _onBoardingEntity;
  OnBoardingStatus? get onBoardingEntity => _$this._onBoardingEntity;
  set onBoardingEntity(OnBoardingStatus? onBoardingEntity) =>
      _$this._onBoardingEntity = onBoardingEntity;

  ProfileMatchRequestStateBuilder();

  ProfileMatchRequestStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onBoardingEntity = $v.onBoardingEntity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileMatchRequestState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileMatchRequestState;
  }

  @override
  void update(void Function(ProfileMatchRequestStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileMatchRequestState build() => _build();

  _$ProfileMatchRequestState _build() {
    final _$result = _$v ??
        new _$ProfileMatchRequestState._(onBoardingEntity: onBoardingEntity);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
