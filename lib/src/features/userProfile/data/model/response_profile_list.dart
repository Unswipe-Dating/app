
import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_interests.dart';


part 'response_profile_list.g.dart';


@JsonSerializable()
class ResponseProfileList {
  ResponseProfileList(this.id, this.userId, this.name, this.interests);

  factory ResponseProfileList.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileListFromJson(json);

  String id;
  String userId;
  String name;
  ResponseProfileInterests interests;
  Map<String, dynamic> toJson() => _$ResponseProfileListToJson(this);
}
