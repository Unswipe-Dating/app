
part of 'update_profile_param_and_response.dart';

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

  UpsertProfile(this.userId,
    this.completed,
    this.datingPreference,
    this.dob,
    this.gender,
    this.id,
    this.interests,
    this.name,
    this.pronouns,
    this.showTruncatedName);


  factory UpsertProfile.fromJson(Map<String, dynamic> json) =>
      _$UpsertProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertProfileToJson(this);


}