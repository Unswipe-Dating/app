
import 'package:json_annotation/json_annotation.dart';

part 'response_contact_block.g.dart';


@JsonSerializable()
class ResponseContactBlock {
  ResponseContactBlock(this.blockUsers);

  factory ResponseContactBlock.fromJson(Map<String, dynamic> json) =>
      _$ResponseContactBlockFromJson(json);

  List<String> blockUsers;
  Map<String, dynamic> toJson() => _$ResponseContactBlockToJson(this);
}
