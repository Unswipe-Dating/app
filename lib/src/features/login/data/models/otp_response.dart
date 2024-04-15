import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  OtpResponse(this.typename,
      this.requestOtp);

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  String requestOtp;
  @JsonKey(name: '__typename')
  String typename;

  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}