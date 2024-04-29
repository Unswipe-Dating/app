import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/validate_otp.dart';

import 'interests_request.dart';

part 'create_user_request.g.dart';

@JsonSerializable()
class CreateUserRequest {
  CreateUserRequest(this.userId,
      this.completed,
      this.datingPreference,
      this.dob,
      this.gender,
      this.interests,
      this.name,
      this.pronouns,
      this.showTruncatedName);

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  String userId;
  bool completed;
  String datingPreference;
  String dob;
  String gender;
  Interests interests;
  String name;
  String pronouns;
  bool showTruncatedName;
  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);
}

