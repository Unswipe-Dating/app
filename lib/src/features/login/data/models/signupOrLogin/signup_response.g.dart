// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      SignUpDataResponse.fromJson(json['signup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'signup': instance.signup,
    };

SignUpUserResponse _$SignUpUserResponseFromJson(Map<String, dynamic> json) =>
    SignUpUserResponse(
      json['id'] as String,
      json['profileId'] as String?,
      json['firebaseCustomToken'] as String,
    );

Map<String, dynamic> _$SignUpUserResponseToJson(SignUpUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profileId': instance.profileId,
      'firebaseCustomToken': instance.firebaseCustomToken,
    };

SignUpDataResponse _$SignUpDataResponseFromJson(Map<String, dynamic> json) =>
    SignUpDataResponse(
      json['accessToken'] as String,
      json['refreshToken'] as String,
      SignUpUserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpDataResponseToJson(SignUpDataResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };
