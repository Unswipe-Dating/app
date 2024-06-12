
part of 'response_meta.dart';

@JsonSerializable()
class FirebaseConfig {
  FirebaseConfig(this.fcmToken);

  factory FirebaseConfig.fromJson(Map<String, dynamic> json) =>
      _$FirebaseConfigFromJson(json);

 String? fcmToken;

  Map<String, dynamic> toJson() => _$FirebaseConfigToJson(this);
}