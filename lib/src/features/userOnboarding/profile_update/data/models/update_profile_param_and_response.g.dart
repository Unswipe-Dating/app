// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_param_and_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileParamAndResponse _$UpdateProfileParamAndResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileParamAndResponse(
      UpsertProfile.fromJson(json['upsertProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateProfileParamAndResponseToJson(
        UpdateProfileParamAndResponse instance) =>
    <String, dynamic>{
      'upsertProfile': instance.upsertProfile,
    };

UpsertProfile _$UpsertProfileFromJson(Map<String, dynamic> json) =>
    UpsertProfile(
      json['userId'] as String?,
      json['completed'] as bool?,
      json['datingPreference'] as String?,
      json['dob'] as String?,
      json['gender'] as String?,
      json['id'] as String?,
      json['interests'] == null
          ? null
          : Interests.fromJson(json['interests'] as Map<String, dynamic>),
      json['name'] as String?,
      json['pronouns'] as String?,
      json['showTruncatedName'] as bool?,
    );

Map<String, dynamic> _$UpsertProfileToJson(UpsertProfile instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'completed': instance.completed,
      'datingPreference': instance.datingPreference,
      'dob': instance.dob,
      'gender': instance.gender,
      'id': instance.id,
      'interests': instance.interests,
      'name': instance.name,
      'pronouns': instance.pronouns,
      'showTruncatedName': instance.showTruncatedName,
    };

Interests _$InterestsFromJson(Map<String, dynamic> json) => Interests(
      (json['weekendActivities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['pets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['selfCare'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['fnd'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['sports'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InterestsToJson(Interests instance) => <String, dynamic>{
      'weekendActivities': instance.weekendActivities,
      'pets': instance.pets,
      'selfCare': instance.selfCare,
      'fnd': instance.fnd,
      'sports': instance.sports,
    };
