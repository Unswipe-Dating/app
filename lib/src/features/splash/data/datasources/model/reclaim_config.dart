
part of 'response_meta.dart';

@JsonSerializable()
class ReclaimConfig {
  ReclaimConfig(this.appId, this.appSecret);

  factory ReclaimConfig.fromJson(Map<String, dynamic> json) =>
      _$ReclaimConfigFromJson(json);

  String appId;
  String appSecret;

  Map<String, dynamic> toJson() => _$ReclaimConfigToJson(this);
}