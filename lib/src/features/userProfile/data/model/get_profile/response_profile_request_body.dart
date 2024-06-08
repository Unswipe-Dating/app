


part of 'response_profile_swipe.dart';


@JsonSerializable()
class ResponseProfileRequestBody {
  ResponseProfileRequestBody(this.id,
      );

  factory ResponseProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileRequestBodyFromJson(json);

  String id;
  Map<String, dynamic> toJson() => _$ResponseProfileRequestBodyToJson(this);
}
