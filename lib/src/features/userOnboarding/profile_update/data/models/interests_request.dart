part of 'update_profile_response.dart';

@JsonSerializable()
class Interests {
  Interests(this.weekendActivities, this.pets, this.selfCare, this.fnd, this.sports);

  factory Interests.fromJson(Map<String, dynamic> json) =>
      _$InterestsFromJson(json);

  List<String>? weekendActivities;
  List<String>? pets;
  List<String>? selfCare;
  List<String>? fnd;
  List<String>? sports;
  Map<String, dynamic> toJson() => _$InterestsToJson(this);
}