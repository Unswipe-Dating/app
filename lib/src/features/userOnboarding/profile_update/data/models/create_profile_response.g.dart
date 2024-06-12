// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProfileResponse _$CreateProfileResponseFromJson(
        Map<String, dynamic> json) =>
    CreateProfileResponse(
      UpsertProfile.fromJson(json['createProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateProfileResponseToJson(
        CreateProfileResponse instance) =>
    <String, dynamic>{
      'createProfile': instance.createProfile,
    };
