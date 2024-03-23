import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:unswipe/src/core/utils/constant/serializers.dart';

part 'on_boarding_token_entity.g.dart';

abstract class OnBoardingTokenEntity
    implements Built<OnBoardingTokenEntity, OnBoardingTokenEntityBuilder> {
  @BuiltValueField(wireName: 'onBoardingToken')
  bool get token;

  static Serializer<OnBoardingTokenEntity> get serializer =>
      _$onBoardingTokenEntitySerializer;

  OnBoardingTokenEntity._();

  factory OnBoardingTokenEntity(
      [void Function(OnBoardingTokenEntityBuilder) updates]) =
  _$OnBoardingTokenEntity;

  factory OnBoardingTokenEntity.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<OnBoardingTokenEntity>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this) as Map<String, dynamic>;
}
