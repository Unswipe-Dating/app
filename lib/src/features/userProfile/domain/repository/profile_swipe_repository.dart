import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';

import '../../../../../../data/api_response.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';
import '../../data/model/response_profile_skip.dart';

abstract class ProfileSwipeRepository {
  Future<ApiResponse<ResponseProfileSwipe>> getProfiles(String token,
      ProfileSwipeParams params);
  Future<ApiResponse<ResponseProfileRequest>> createRequest(String token,
      ProfileSwipeParams params);
  Future<ApiResponse<ResponseProfileRequest>> rejectRequest(String token,
      ProfileSwipeParams params);
  Future<ApiResponse<ResponseProfileRequest>> acceptRequest(String token,
      ProfileSwipeParams params);
  Future<ApiResponse<ResponseProfileSkip>> skipRequest(String token,
      ProfileSwipeParams params);
  Future<ApiResponse<ResponseProfileSwipe>> getRequestedProfiles(String token,
      ProfileSwipeParams params);

}

class ProfileSwipeParams {
  final String? userId;
  final String? matchUserId;


  ProfileSwipeParams({
    this.userId,
    this.matchUserId,
  });
}
