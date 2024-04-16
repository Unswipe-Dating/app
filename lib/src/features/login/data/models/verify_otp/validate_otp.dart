import 'package:json_annotation/json_annotation.dart';

part 'validate_otp.g.dart';

@JsonSerializable()
class ValidateOtp {
  ValidateOtp(this.accessToken, this.refreshToken);

  factory ValidateOtp.fromJson(Map<String, dynamic> json) =>
      _$ValidateOtpFromJson(json);

  String accessToken;
  String refreshToken;

  Map<String, dynamic> toJson() => _$ValidateOtpToJson(this);
}
