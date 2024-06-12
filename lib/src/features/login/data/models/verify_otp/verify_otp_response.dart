import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/validate_otp.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  VerifyOtpResponse(this.validateOTP);

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  ValidateOtp validateOTP;

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);
}

