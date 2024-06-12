
import 'package:json_annotation/json_annotation.dart';

part 'response_profile_request.g.dart';
part 'response_profile_create_request.dart';

part 'response_profile_request_challenge.dart';


@JsonSerializable()
class ResponseProfileRequest {
  ResponseProfileRequest(this.createRequest, this.rejectRequest, this.matchRequest);

  factory ResponseProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileRequestFromJson(json);

  ResponseProfileCreateRequest? createRequest;
  ResponseProfileCreateRequest? rejectRequest;
  ResponseProfileCreateRequest? matchRequest;



  Map<String, dynamic> toJson() => _$ResponseProfileRequestToJson(this);
}
