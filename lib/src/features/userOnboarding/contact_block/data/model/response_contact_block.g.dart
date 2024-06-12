// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_contact_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseContactBlock _$ResponseContactBlockFromJson(
        Map<String, dynamic> json) =>
    ResponseContactBlock(
      (json['blockUsers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseContactBlockToJson(
        ResponseContactBlock instance) =>
    <String, dynamic>{
      'blockUsers': instance.blockUsers,
    };
