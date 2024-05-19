part of 'response_profile_swipe.dart';

@JsonSerializable()
class ResponseProfileSwipeInterests {
  ResponseProfileSwipeInterests(this.weekendActivities, this.pets, this.selfCare, this.fnd, this.sports);

  factory ResponseProfileSwipeInterests.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileSwipeInterestsFromJson(json);

  List<String>? weekendActivities;
  List<String>? pets;
  List<String>? selfCare;
  List<String>? fnd;
  List<String>? sports;
  Map<String, dynamic> toJson() => _$ResponseProfileSwipeInterestsToJson(this);
}