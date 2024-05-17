part of 'response_profile_swipe.dart';
@JsonSerializable()
class ResponseProfileSwipeBrowse {
  ResponseProfileSwipeBrowse(this.profiles, this.hasNext, this.nextCursor);

  factory ResponseProfileSwipeBrowse.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileSwipeBrowseFromJson(json);

  List<ResponseProfileList> profiles;
  bool? hasNext;
  int? nextCursor;


  Map<String, dynamic> toJson() => _$ResponseProfileSwipeBrowseToJson(this);
}