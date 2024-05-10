// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile_interests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileInterests _$ResponseProfileInterestsFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileInterests(
      (json['weekendActivities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['pets'] as List<dynamic>).map((e) => e as String).toList(),
      (json['selfCare'] as List<dynamic>).map((e) => e as String).toList(),
      (json['fnd'] as List<dynamic>).map((e) => e as String).toList(),
      (json['sports'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseProfileInterestsToJson(
        ResponseProfileInterests instance) =>
    <String, dynamic>{
      'weekendActivities': instance.weekendActivities,
      'pets': instance.pets,
      'selfCare': instance.selfCare,
      'fnd': instance.fnd,
      'sports': instance.sports,
    };
