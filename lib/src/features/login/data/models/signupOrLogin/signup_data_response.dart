
part of 'signup_response.dart';

@JsonSerializable()
class SignUpDataResponse {
  SignUpDataResponse(this.accessToken, this.refreshToken, this.user);

  factory SignUpDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpDataResponseFromJson(json);

  String accessToken;
  String refreshToken;
  SignUpUserResponse user;

  Map<String, dynamic> toJson() => _$SignUpDataResponseToJson(this);
}