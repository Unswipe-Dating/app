import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';

import '../../../../../../data/api_response.dart';
import '../../data/models/create_profile_response.dart';

abstract class UpdateProfileRepository {
  Future<ApiResponse<UpdateProfileResponse>> updateUser(String token, UpdateProfileParams request);
  Future<ApiResponse<CreateProfileResponse>> createUser(String token, UpdateProfileParams request);

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
  List<String>? locationCoordinates;

  UpdateProfileParams({this.userId,
      this.completed,
      this.datingPreference,
      this.dob,
      this.gender,
      this.id,
      this.interests,
      this.name,
      this.pronouns,
      this.showTruncatedName,
    this.locationCoordinates,
  }
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




