
import 'package:json_annotation/json_annotation.dart';
import '../../../userOnboarding/profile_update/data/models/update_profile_response.dart';

part 'response_profile_swipe.g.dart';
part 'response_profile_swipe_browse.dart';
part 'response_profile_list.dart';
part 'response_profile_swipe_interests.dart';


@JsonSerializable()
class ResponseProfileSwipe {
  ResponseProfileSwipe(this.browseProfiles);

  factory ResponseProfileSwipe.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileSwipeFromJson(json);

  ResponseProfileSwipeBrowse browseProfiles;

  Map<String, dynamic> toJson() => _$ResponseProfileSwipeToJson(this);
}
