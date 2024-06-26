// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileRequest _$ResponseProfileRequestFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileRequest(
      json['createRequest'] == null
          ? null
          : ResponseProfileCreateRequest.fromJson(
              json['createRequest'] as Map<String, dynamic>),
      json['rejectRequest'] == null
          ? null
          : ResponseProfileCreateRequest.fromJson(
              json['rejectRequest'] as Map<String, dynamic>),
      json['matchRequest'] == null
          ? null
          : ResponseProfileCreateRequest.fromJson(
              json['matchRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileRequestToJson(
        ResponseProfileRequest instance) =>
    <String, dynamic>{
      'createRequest': instance.createRequest,
      'rejectRequest': instance.rejectRequest,
      'matchRequest': instance.matchRequest,
    };

ResponseProfileCreateRequest _$ResponseProfileCreateRequestFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileCreateRequest(
      json['id'] as String,
      json['type'] as String,
      json['requesteeUserId'] as String,
      json['userId'] as String,
      json['userProfileImage'] as String?,
      json['requesteeProfileImage'] as String?,
      json['expiry'] as String,
      json['status'] as String,
      json['challengeVerification'] as String?,
      json['challengeVerificationStatus'] as String,
      json['challenge'] == null
          ? null
          : ResponseProfileRequestChallenge.fromJson(
              json['challenge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileCreateRequestToJson(
        ResponseProfileCreateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'userProfileImage': instance.userProfileImage,
      'requesteeProfileImage': instance.requesteeProfileImage,
      'userId': instance.userId,
      'expiry': instance.expiry,
      'status': instance.status,
      'requesteeUserId': instance.requesteeUserId,
      'challengeVerification': instance.challengeVerification,
      'challengeVerificationStatus': instance.challengeVerificationStatus,
      'challenge': instance.challenge,
    };

ResponseProfileRequestChallenge _$ResponseProfileRequestChallengeFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileRequestChallenge(
      (json['weeklyDates'] as num).toInt(),
      (json['amountUSD'] as num).toInt(),
    );

Map<String, dynamic> _$ResponseProfileRequestChallengeToJson(
        ResponseProfileRequestChallenge instance) =>
    <String, dynamic>{
      'weeklyDates': instance.weeklyDates,
      'amountUSD': instance.amountUSD,
    };
