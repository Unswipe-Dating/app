
part of 'response_meta.dart';

@JsonSerializable()
class MetaConfigChat {
  MetaConfigChat(
      this.id,
      this.roomId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId,

      );

  factory MetaConfigChat.fromJson(Map<String, dynamic> json) =>
      _$MetaConfigChatFromJson(json);

  String id;
  String roomId;
  String status;
  String createdAt;
  String updatedAt;
  String userId;

  Map<String, dynamic> toJson() => _$MetaConfigChatToJson(this);
}