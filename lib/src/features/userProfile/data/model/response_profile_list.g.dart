// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileList _$ResponseProfileListFromJson(Map<String, dynamic> json) =>
    ResponseProfileList(
      json['id'] as String,
      json['userId'] as String,
      json['name'] as String,
      ResponseProfileInterests.fromJson(
          json['interests'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileListToJson(
        ResponseProfileList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'interests': instance.interests,
    };
