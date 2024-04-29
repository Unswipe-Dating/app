import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  OtpResponse(this.orderId);

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  String orderId;

  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}