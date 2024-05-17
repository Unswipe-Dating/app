import '../../../../../../data/api_response.dart';
import '../../data/model/response_profile_swipe.dart';

abstract class ProfileSwipeRepository {
  Future<ApiResponse<ResponseProfileSwipe>> getProfiles(String token,
      ProfileSwipeParams params);


}

class ProfileSwipeParams {
  late final String userId;


  ProfileSwipeParams({
    required this.userId,
  });
}
