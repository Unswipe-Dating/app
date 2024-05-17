
part of 'signup_response.dart';

@JsonSerializable()
class SignUpUserProfileResponse {
  SignUpUserProfileResponse(this.id);

  factory SignUpUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpUserProfileResponseFromJson(json);

  String? id;

  Map<String, dynamic> toJson() => _$SignUpUserProfileResponseToJson(this);
}