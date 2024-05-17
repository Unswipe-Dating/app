part of 'signup_response.dart';

@JsonSerializable()
class SignUpUserResponse {
  SignUpUserResponse(this.id, this.profile);

  factory SignUpUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpUserResponseFromJson(json);

  String id;
  SignUpUserProfileResponse? profile;

  Map<String, dynamic> toJson() => _$SignUpUserResponseToJson(this);
}