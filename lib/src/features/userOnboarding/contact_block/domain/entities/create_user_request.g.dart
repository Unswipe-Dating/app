// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    CreateUserRequest(
      json['userId'] as String,
      json['completed'] as bool,
      json['datingPreference'] as String,
      json['dob'] as String,
      json['gender'] as String,
      Interests.fromJson(json['interests'] as Map<String, dynamic>),
      json['name'] as String,
      json['pronouns'] as String,
      json['showTruncatedName'] as bool,
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'completed': instance.completed,
      'datingPreference': instance.datingPreference,
      'dob': instance.dob,
      'gender': instance.gender,
      'interests': instance.interests,
      'name': instance.name,
      'pronouns': instance.pronouns,
      'showTruncatedName': instance.showTruncatedName,
    };
