


part of 'response_profile_swipe.dart';


@JsonSerializable()
class ResponseProfileList {
  ResponseProfileList(this.id,
      this.userId,
      this.name,
      this.interests,
      this.photoURLs,
      this.location,
      this.dob,
      this.datingPreference,
      this.height,
      this.hometown,
      this.zodiac,
      this.languages,
      this.request,
      this.pronouns,
      this.gender,
      this.showTruncatedName,
      );

  factory ResponseProfileList.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileListFromJson(json);

  String id;
  String userId;
  String name;
  ResponseProfileSwipeInterests interests;
  List<String> photoURLs;
  String? location;
  String? dob;
  String? datingPreference;
  String? height;
  String? hometown;
  String? zodiac;
  String? pronouns;
  String? gender;
  bool? showTruncatedName;
  List<String>? languages;
  ResponseProfileRequestBody? request;
  Map<String, dynamic> toJson() => _$ResponseProfileListToJson(this);
}
