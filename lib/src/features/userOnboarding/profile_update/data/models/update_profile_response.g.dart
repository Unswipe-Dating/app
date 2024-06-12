// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileResponse _$UpdateProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileResponse(
      UpsertProfile.fromJson(json['updateProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateProfileResponseToJson(
        UpdateProfileResponse instance) =>
    <String, dynamic>{
      'updateProfile': instance.updateProfile,
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
      json['homeTown'] as String?,
      json['height'] as String?,
      (json['locationCoordinates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['zodiac'] as String?,
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
      'homeTown': instance.homeTown,
      'height': instance.height,
      'locationCoordinates': instance.locationCoordinates,
      'zodiac': instance.zodiac,
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
