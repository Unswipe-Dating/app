
import 'package:json_annotation/json_annotation.dart';

part 'response_profile_interests.g.dart';


@JsonSerializable()
class ResponseProfileInterests {
  ResponseProfileInterests(this.weekendActivities, this.pets, this.selfCare, this.fnd, this.sports);

  factory ResponseProfileInterests.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileInterestsFromJson(json);

  List<String> weekendActivities;
  List<String> pets;
  List<String> selfCare;
  List<String> fnd;
  List<String> sports;
  Map<String, dynamic> toJson() => _$ResponseProfileInterestsToJson(this);
}