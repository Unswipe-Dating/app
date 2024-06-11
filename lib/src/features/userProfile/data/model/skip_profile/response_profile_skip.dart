import 'package:json_annotation/json_annotation.dart';

part 'response_profile_skip.g.dart';

@JsonSerializable()
class ResponseProfileSkip {
  ResponseProfileSkip(this.skipProfile,);

  factory ResponseProfileSkip.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileSkipFromJson(json);

  String skipProfile;



  Map<String, dynamic> toJson() => _$ResponseProfileSkipToJson(this);
}