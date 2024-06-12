import 'package:json_annotation/json_annotation.dart';

part 'response_image_upload.g.dart';

@JsonSerializable()
class ResponseImageUpload {
  ResponseImageUpload(this.uploadProfilePhotos);

  factory ResponseImageUpload.fromJson(Map<String, dynamic> json) =>
      _$ResponseImageUploadFromJson(json);

  String uploadProfilePhotos;
  Map<String, dynamic> toJson() => _$ResponseImageUploadToJson(this);
}