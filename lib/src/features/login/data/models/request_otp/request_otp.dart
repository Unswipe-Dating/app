
import 'package:json_annotation/json_annotation.dart';

part 'request_otp.g.dart';


@JsonSerializable()
class RequestOtp {
  RequestOtp(this.orderId);

  factory RequestOtp.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpFromJson(json);

  String orderId;

  Map<String, dynamic> toJson() => _$RequestOtpToJson(this);
}