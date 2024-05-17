
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_response.g.dart';
part 'upsert_profile.dart';
part 'interests_request.dart';

@JsonSerializable()
class UpdateProfileResponse {
  UpdateProfileResponse(this.updateProfile);

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseFromJson(json);

  UpsertProfile updateProfile;

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);
}