// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMeta _$ResponseMetaFromJson(Map<String, dynamic> json) => ResponseMeta(
      MetaConfig.fromJson(json['getConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMetaToJson(ResponseMeta instance) =>
    <String, dynamic>{
      'getConfig': instance.getConfig,
    };

MetaConfig _$MetaConfigFromJson(Map<String, dynamic> json) => MetaConfig(
      FirebaseConfig.fromJson(json['firebase'] as Map<String, dynamic>),
      ReclaimConfig.fromJson(json['reclaim'] as Map<String, dynamic>),
      json['timeLeftForExpiry'] as int?,
    );

Map<String, dynamic> _$MetaConfigToJson(MetaConfig instance) =>
    <String, dynamic>{
      'firebase': instance.firebase,
      'reclaim': instance.reclaim,
      'timeLeftForExpiry': instance.timeLeftForExpiry,
    };

FirebaseConfig _$FirebaseConfigFromJson(Map<String, dynamic> json) =>
    FirebaseConfig(
      json['fcmToken'] as String?,
    );

Map<String, dynamic> _$FirebaseConfigToJson(FirebaseConfig instance) =>
    <String, dynamic>{
      'fcmToken': instance.fcmToken,
    };

ReclaimConfig _$ReclaimConfigFromJson(Map<String, dynamic> json) =>
    ReclaimConfig(
      json['appId'] as String,
      json['appSecret'] as String,
    );

Map<String, dynamic> _$ReclaimConfigToJson(ReclaimConfig instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'appSecret': instance.appSecret,
    };
