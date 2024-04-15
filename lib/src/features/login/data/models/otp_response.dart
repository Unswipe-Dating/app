import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  OtpResponse(this.requestOTP);

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  String requestOTP;

  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}