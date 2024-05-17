
import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';

part 'create_profile_response.g.dart';

@JsonSerializable()
class CreateProfileResponse {
  CreateProfileResponse(this.createProfile);

  factory CreateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateProfileResponseFromJson(json);

  UpsertProfile createProfile;

  Map<String, dynamic> toJson() => _$CreateProfileResponseToJson(this);
}