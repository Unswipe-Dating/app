import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/settings/data/datasources/remote/UserSettingService.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';

import '../../../userProfile/data/model/get_profile/response_profile_swipe.dart';

@Injectable(as: UserSettingsRepository)
class UserSettingsRepositoryImpl extends UserSettingsRepository {
  final UserSettingService services;

  UserSettingsRepositoryImpl(
    this.services,
  );

  @override
  Future<ApiResponse<ResponseProfileSwipe>> getProfile(
      String token, String id) async {
    final response = await services.getProfile(token, id);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseProfileSwipe;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is AuthorizationFailure) {
      return AuthorizationFailure(
          error: (response as AuthorizationFailure).error);
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }
}
