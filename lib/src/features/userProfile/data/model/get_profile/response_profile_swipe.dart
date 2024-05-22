
import 'package:json_annotation/json_annotation.dart';

part 'response_profile_swipe.g.dart';
part 'response_profile_swipe_browse.dart';
part 'response_profile_list.dart';
part 'response_profile_swipe_interests.dart';


@JsonSerializable()
class ResponseProfileSwipe {
  ResponseProfileSwipe(this.browseProfiles, this.getRequestedProfilesForUser);

  factory ResponseProfileSwipe.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileSwipeFromJson(json);

  ResponseProfileSwipeBrowse? browseProfiles;
  List<ResponseProfileList>? getRequestedProfilesForUser;


  Map<String, dynamic> toJson() => _$ResponseProfileSwipeToJson(this);
}
