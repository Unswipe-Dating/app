import 'dart:async';

import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_param_and_response.dart';

import '../../../../../../data/api_response.dart';

abstract class UpdateProfileRepository {
  Future<ApiResponse<UpdateProfileParamAndResponse>> upsertUser(String token, UpdateProfileParams request);
}


class UpdateProfileParams {
  String? userId;
  bool? completed;
  String? datingPreference;
  String? dob;
  String? gender;
  String? id;
  Interests? interests;
  String? name;
  String? pronouns;
  bool? showTruncatedName;

  UpdateProfileParams({this.userId,
      this.completed,
      this.datingPreference,
      this.dob,
      this.gender,
      this.id,
      this.interests,
      this.name,
      this.pronouns,
      this.showTruncatedName}
      );

  UpdateProfileParams getUpdatedParams(UpdateProfileParams? params) {
    return UpdateProfileParams(userId: params?.userId,
        completed: params?.completed,
        datingPreference: params?.datingPreference,
      dob: params?.dob,
      gender: params?.gender,
      id: params?.id,
      interests: params?.interests,
      name: params?.name,
      pronouns: params?.pronouns,
      showTruncatedName: params?.showTruncatedName
    );
  }
}




