// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_boarding_token_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OnBoardingTokenEntity> _$onBoardingTokenEntitySerializer =
    new _$OnBoardingTokenEntitySerializer();

class _$OnBoardingTokenEntitySerializer
    implements StructuredSerializer<OnBoardingTokenEntity> {
  @override
  final Iterable<Type> types = const [
    OnBoardingTokenEntity,
    _$OnBoardingTokenEntity
  ];
  @override
  final String wireName = 'OnBoardingTokenEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, OnBoardingTokenEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'onBoardingToken',
      serializers.serialize(object.token, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  OnBoardingTokenEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OnBoardingTokenEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'onBoardingToken':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$OnBoardingTokenEntity extends OnBoardingTokenEntity {
  @override
  final bool token;

  factory _$OnBoardingTokenEntity(
          [void Function(OnBoardingTokenEntityBuilder)? updates]) =>
      (new OnBoardingTokenEntityBuilder()..update(updates))._build();

  _$OnBoardingTokenEntity._({required this.token}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        token, r'OnBoardingTokenEntity', 'token');
  }

  @override
  OnBoardingTokenEntity rebuild(
          void Function(OnBoardingTokenEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OnBoardingTokenEntityBuilder toBuilder() =>
      new OnBoardingTokenEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnBoardingTokenEntity && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OnBoardingTokenEntity')
          ..add('token', token))
        .toString();
  }
}

class OnBoardingTokenEntityBuilder
    implements Builder<OnBoardingTokenEntity, OnBoardingTokenEntityBuilder> {
  _$OnBoardingTokenEntity? _$v;

  bool? _token;
  bool? get token => _$this._token;
  set token(bool? token) => _$this._token = token;

  OnBoardingTokenEntityBuilder();

  OnBoardingTokenEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnBoardingTokenEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OnBoardingTokenEntity;
  }

  @override
  void update(void Function(OnBoardingTokenEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OnBoardingTokenEntity build() => _build();

  _$OnBoardingTokenEntity _build() {
    final _$result = _$v ??
        new _$OnBoardingTokenEntity._(
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'OnBoardingTokenEntity', 'token'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
