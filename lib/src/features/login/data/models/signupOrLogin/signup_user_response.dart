part of 'signup_response.dart';

@JsonSerializable()
class SignUpUserResponse {
  SignUpUserResponse(this.id, this.profileId);

  factory SignUpUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpUserResponseFromJson(json);

  String id;
  String? profileId;

  Map<String, dynamic> toJson() => _$SignUpUserResponseToJson(this);
}