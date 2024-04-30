import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/validate_otp.dart';

part 'upload_image_response.g.dart';

@JsonSerializable()
class UploadImageResponse {
  UploadImageResponse(this.successMessage);

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseFromJson(json);

  String successMessage;

  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}

