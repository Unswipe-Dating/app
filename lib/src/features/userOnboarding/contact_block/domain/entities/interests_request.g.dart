// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interests_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interests _$InterestsFromJson(Map<String, dynamic> json) => Interests()
  ..weekendActivities = (json['weekendActivities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList()
  ..pets = (json['pets'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..selfCare =
      (json['selfCare'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..fnd = (json['fnd'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..sports =
      (json['sports'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$InterestsToJson(Interests instance) => <String, dynamic>{
      'weekendActivities': instance.weekendActivities,
      'pets': instance.pets,
      'selfCare': instance.selfCare,
      'fnd': instance.fnd,
      'sports': instance.sports,
    };
