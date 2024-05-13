import 'dart:async';

import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_param_and_response.dart';

import '../../../../../../data/api_response.dart';

abstract class UpdateProfileRepository {
  Future<ApiResponse<UpdateProfileParamAndResponse>> upsertUser(String token, UpdateProfileParamAndResponse request);
}



