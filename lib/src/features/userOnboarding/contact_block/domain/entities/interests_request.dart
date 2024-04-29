import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/validate_otp.dart';

part 'interests_request.g.dart';

@JsonSerializable()
class Interests {
  Interests();

  factory Interests.fromJson(Map<String, dynamic> json) =>
      _$InterestsFromJson(json);

  List<String>? weekendActivities;
  List<String>? pets;
  List<String>? selfCare;
  List<String>? fnd;
  List<String>? sports;
  Map<String, dynamic> toJson() => _$InterestsToJson(this);
}