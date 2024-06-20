import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';
import 'package:unswipe/src/features/userProfile/data/model/get_profile/response_profile_swipe.dart';

abstract class UserSettingsRepository {
  Future<ApiResponse<ResponseProfileSwipe>> getProfile(String token, String id);


}

class SettingProfileParams {
  UpdateProfileParams? updateParams;
  ResponseProfileList? profileParams;

  SettingProfileParams({this.updateParams,
    this.profileParams,
  }
      );
}
