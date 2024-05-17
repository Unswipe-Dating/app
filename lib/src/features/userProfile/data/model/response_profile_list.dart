


part of 'response_profile_swipe.dart';


@JsonSerializable()
class ResponseProfileList {
  ResponseProfileList(this.id,
      this.userId,
      this.name, this.interests, this.photoURLs, this.location);

  factory ResponseProfileList.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileListFromJson(json);

  String id;
  String userId;
  String name;
  ResponseProfileSwipeInterests interests;
  List<String> photoURLs;
  String location;
  Map<String, dynamic> toJson() => _$ResponseProfileListToJson(this);
}
