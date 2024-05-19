import '../../../../../../data/api_response.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';

abstract class ProfileSwipeRepository {
  Future<ApiResponse<ResponseProfileSwipe>> getProfiles(String token,
      ProfileSwipeParams params);


}

class ProfileSwipeParams {
  final String? id;
  final String? userId;
  final String? matchUserId;


  ProfileSwipeParams({
    this.id,
    this.userId,
    this.matchUserId,
  });
}
