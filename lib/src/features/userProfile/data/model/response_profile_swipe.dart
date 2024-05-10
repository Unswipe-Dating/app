
import 'package:json_annotation/json_annotation.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_interests.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_list.dart';

import '../../../userOnboarding/domain/entities/interests_request.dart';

part 'response_profile_swipe.g.dart';


@JsonSerializable()
class ResponseProfileSwipe {
  ResponseProfileSwipe(this.browseProfiles);

  factory ResponseProfileSwipe.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileSwipeFromJson(json);

  List<ResponseProfileList> browseProfiles;

  Map<String, dynamic> toJson() => _$ResponseProfileSwipeToJson(this);
}
