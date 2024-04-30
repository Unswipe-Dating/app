import 'package:json_annotation/json_annotation.dart';

part 'block_contact_response.g.dart';

@JsonSerializable()
class BlockContactResponse {
  BlockContactResponse(this.successMessage);

  factory BlockContactResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockContactResponseFromJson(json);

  String successMessage;

  Map<String, dynamic> toJson() => _$BlockContactResponseToJson(this);
}