// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile_swipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileSwipe _$ResponseProfileSwipeFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileSwipe(
      (json['browseProfiles'] as List<dynamic>)
          .map((e) => ResponseProfileList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseProfileSwipeToJson(
        ResponseProfileSwipe instance) =>
    <String, dynamic>{
      'browseProfiles': instance.browseProfiles,
    };
