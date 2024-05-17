part of 'update_profile_response.dart';

@JsonSerializable()
class UpsertProfile {
  String? userId;
  bool? completed;
  String? datingPreference;
  String? dob;
  String? gender;
  String? id;
  Interests? interests;
  String? name;
  String? pronouns;
  bool? showTruncatedName;
  String? homeTown;
  String? height;
  List<String>? locationCoordinates;
  String? zodiac;

  UpsertProfile(
      this.userId,
      this.completed,
      this.datingPreference,
      this.dob,
      this.gender,
      this.id,
      this.interests,
      this.name,
      this.pronouns,
      this.showTruncatedName,
      this.homeTown,
      this.height,
      this.locationCoordinates,
      this.zodiac);

  factory UpsertProfile.fromJson(Map<String, dynamic> json) =>
      _$UpsertProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertProfileToJson(this);
}
