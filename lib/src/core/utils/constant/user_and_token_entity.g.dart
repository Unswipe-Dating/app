// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_and_token_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserAndTokenEntity> _$userAndTokenEntitySerializer =
    new _$UserAndTokenEntitySerializer();

class _$UserAndTokenEntitySerializer
    implements StructuredSerializer<UserAndTokenEntity> {
  @override
  final Iterable<Type> types = const [UserAndTokenEntity, _$UserAndTokenEntity];
  @override
  final String wireName = 'UserAndTokenEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UserAndTokenEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserAndTokenEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserAndTokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UserAndTokenEntity extends UserAndTokenEntity {
  @override
  final String token;
  @override
  final String id;
  @override
  final String? userId;

  factory _$UserAndTokenEntity(
          [void Function(UserAndTokenEntityBuilder)? updates]) =>
      (new UserAndTokenEntityBuilder()..update(updates))._build();

  _$UserAndTokenEntity._({required this.token, required this.id, this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        token, r'UserAndTokenEntity', 'token');
    BuiltValueNullFieldError.checkNotNull(id, r'UserAndTokenEntity', 'id');
  }

  @override
  UserAndTokenEntity rebuild(
          void Function(UserAndTokenEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserAndTokenEntityBuilder toBuilder() =>
      new UserAndTokenEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserAndTokenEntity &&
        token == other.token &&
        id == other.id &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserAndTokenEntity')
          ..add('token', token)
          ..add('id', id)
          ..add('userId', userId))
        .toString();
  }
}

class UserAndTokenEntityBuilder
    implements Builder<UserAndTokenEntity, UserAndTokenEntityBuilder> {
  _$UserAndTokenEntity? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  UserAndTokenEntityBuilder();

  UserAndTokenEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _id = $v.id;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserAndTokenEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserAndTokenEntity;
  }

  @override
  void update(void Function(UserAndTokenEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserAndTokenEntity build() => _build();

  _$UserAndTokenEntity _build() {
    final _$result = _$v ??
        new _$UserAndTokenEntity._(
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'UserAndTokenEntity', 'token'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'UserAndTokenEntity', 'id'),
            userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
