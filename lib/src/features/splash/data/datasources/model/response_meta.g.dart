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
      json['timeLeftForExpiry'] as String?,
    )
      ..status = json['status'] as String?
      ..request = json['request'] == null
          ? null
          : ResponseProfileCreateRequest.fromJson(
              json['request'] as Map<String, dynamic>)
      ..chat = json['chat'] == null
          ? null
          : MetaConfigChat.fromJson(json['chat'] as Map<String, dynamic>);

Map<String, dynamic> _$MetaConfigToJson(MetaConfig instance) =>
    <String, dynamic>{
      'firebase': instance.firebase,
      'reclaim': instance.reclaim,
      'timeLeftForExpiry': instance.timeLeftForExpiry,
      'status': instance.status,
      'request': instance.request,
      'chat': instance.chat,
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

MetaConfigChat _$MetaConfigChatFromJson(Map<String, dynamic> json) =>
    MetaConfigChat(
      json['id'] as String,
      json['roomId'] as String,
      json['status'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
      json['userId'] as String,
    );

Map<String, dynamic> _$MetaConfigChatToJson(MetaConfigChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
    };
