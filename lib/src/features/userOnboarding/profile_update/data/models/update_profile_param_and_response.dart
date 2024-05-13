
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_param_and_response.g.dart';
part 'upsert_profile.dart';
part 'interests_request.dart';

@JsonSerializable()
class UpdateProfileParamAndResponse {
  UpdateProfileParamAndResponse(this.upsertProfile);

  factory UpdateProfileParamAndResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileParamAndResponseFromJson(json);

  UpsertProfile upsertProfile;

  Map<String, dynamic> toJson() => _$UpdateProfileParamAndResponseToJson(this);
}