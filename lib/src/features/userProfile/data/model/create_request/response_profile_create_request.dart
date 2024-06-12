

part of 'response_profile_request.dart';


@JsonSerializable()
class ResponseProfileCreateRequest {
  ResponseProfileCreateRequest(
      this.id,
      this.type,
      this.requesterProfileId,
      this.requesteeProfileId,
      this.expiry,
      this.status,
      this.challengeVerification,
      this.challengeVerificationStatus,
      this.challenge
      );

  factory ResponseProfileCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileCreateRequestFromJson(json);

  String id;
  String type;
  String requesterProfileId;
  String requesteeProfileId;
  String expiry;
  String status;
  String? challengeVerification;
  String challengeVerificationStatus;
  ResponseProfileRequestChallenge? challenge;


  Map<String, dynamic> toJson() => _$ResponseProfileCreateRequestToJson(this);
}
