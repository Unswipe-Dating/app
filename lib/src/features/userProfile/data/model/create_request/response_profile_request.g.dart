// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileRequest _$ResponseProfileRequestFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileRequest(
      ResponseProfileCreateRequest.fromJson(
          json['createRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileRequestToJson(
        ResponseProfileRequest instance) =>
    <String, dynamic>{
      'createRequest': instance.createRequest,
    };

ResponseProfileCreateRequest _$ResponseProfileCreateRequestFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileCreateRequest(
      json['id'] as String,
      json['type'] as String,
      json['requesterProfileId'] as String,
      json['requesteeProfileId'] as String,
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
      'requesterProfileId': instance.requesterProfileId,
      'requesteeProfileId': instance.requesteeProfileId,
      'expiry': instance.expiry,
      'status': instance.status,
      'challengeVerification': instance.challengeVerification,
      'challengeVerificationStatus': instance.challengeVerificationStatus,
      'challenge': instance.challenge,
    };

ResponseProfileRequestChallenge _$ResponseProfileRequestChallengeFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileRequestChallenge(
      json['weeklyDates'] as int,
      json['amountUSD'] as int,
    );

Map<String, dynamic> _$ResponseProfileRequestChallengeToJson(
        ResponseProfileRequestChallenge instance) =>
    <String, dynamic>{
      'weeklyDates': instance.weeklyDates,
      'amountUSD': instance.amountUSD,
    };
