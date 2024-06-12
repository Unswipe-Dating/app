import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';
part 'signup_user_response.dart';
part 'signup_data_response.dart';

@JsonSerializable()
class SignUpResponse {
  SignUpResponse(this.signup);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  SignUpDataResponse signup;

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}