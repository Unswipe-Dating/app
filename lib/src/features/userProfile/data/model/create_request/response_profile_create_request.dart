part of 'response_profile_request.dart';

@JsonSerializable()
class ResponseProfileCreateRequest {
  ResponseProfileCreateRequest(
      this.id,
      this.type,
      this.requesteeUserId,
      this.userId,
      this.userProfileImage,
      this.requesteeProfileImage,
      this.expiry,
      this.status,
      this.challengeVerification,
      this.challengeVerificationStatus,
      this.challenge);

  factory ResponseProfileCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileCreateRequestFromJson(json);

  String id;
  String type;
  String? userProfileImage;
  String? requesteeProfileImage;
  String userId;
  String expiry;
  String status;
  String requesteeUserId;
  String? challengeVerification;
  String challengeVerificationStatus;
  ResponseProfileRequestChallenge? challenge;

  Map<String, dynamic> toJson() => _$ResponseProfileCreateRequestToJson(this);
}
