
part of 'response_meta.dart';

@JsonSerializable()
class MetaConfig {
  MetaConfig(this.firebase, this.reclaim, this.timeLeftForExpiry);

  factory MetaConfig.fromJson(Map<String, dynamic> json) =>
      _$MetaConfigFromJson(json);

  FirebaseConfig firebase;
  ReclaimConfig reclaim;
  String? timeLeftForExpiry;
  String? status;
  ResponseProfileCreateRequest? request;

  Map<String, dynamic> toJson() => _$MetaConfigToJson(this);
}