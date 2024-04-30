import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/request_otp.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  OtpResponse(this.requestOTP);

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  RequestOtp requestOTP;

  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}