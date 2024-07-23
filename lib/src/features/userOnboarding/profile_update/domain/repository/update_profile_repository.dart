import 'dart:async';

import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userProfile/data/model/get_profile/response_profile_swipe.dart';

import '../../../../../../data/api_response.dart';
import '../../data/models/create_profile_response.dart';

abstract class UpdateProfileRepository {
  Future<ApiResponse<UpdateProfileResponse>> updateUser(
      String token, UpdateProfileParams request);

  Future<ApiResponse<CreateProfileResponse>> createUser(
      String token, UpdateProfileParams request);
}

class UpdateProfileParams {
  String? userId;
  String? datingPreference;
  String? dob;
  String? gender;
  String? id;
  Interests? interests;
  String? name;
  String? pronouns;
  String? height;
  String? hometown;
  String? zodiac;
  List<String>? languages;
  ResponseProfileWork? work;
  ResponseProfileValues? values;
  ResponseProfileLifeStyle? lifeStyle;
  bool? showTruncatedName;
  bool? showPronoun;
  bool? showGender;
  bool? showDatingPreference;
  List<String>? locationCoordinates;


  UpdateProfileParams({
    this.userId,
    this.datingPreference,
    this.dob,
    this.gender,
    this.id,
    this.interests,
    this.name,
    this.pronouns,
    this.showTruncatedName,
    this.locationCoordinates,
    this.showPronoun,
    this.showDatingPreference,
    this.showGender,
    this.height,
    this.hometown,
    this.zodiac,
    this.languages,
    this.work,
    this.lifeStyle,
    this.values
  });

   static UpdateProfileParams getUpdatedParams(UpdateProfileParams? params) {
    return UpdateProfileParams(
      userId: params?.userId,
      datingPreference: params?.datingPreference,
      dob: params?.dob,
      gender: params?.gender,
      id: params?.id,
      interests: params?.interests,
      name: params?.name,
      pronouns: params?.pronouns,
      showTruncatedName: params?.showTruncatedName,
      locationCoordinates: params?.locationCoordinates,
      showPronoun: params?.showPronoun,
      showDatingPreference: params?.showDatingPreference,
      showGender: params?.showGender,
      height: params?.height,
      hometown: params?.hometown,
      zodiac: params?.zodiac,
      languages: params?.languages,
      work: params?.work,
      lifeStyle: params?.lifeStyle,
      values: params?.values,
    );
  }

  static UpdateProfileParams getUpdatedParamsFromProfile(ResponseProfileList? params) {
    return UpdateProfileParams(
      userId: params?.userId,
      datingPreference: params?.datingPreference,
      dob: params?.dob,
      gender: params?.gender,
      id: params?.id,
      interests: Interests(
        params?.interests.weekendActivities,
        params?.interests.pets,
        params?.interests.selfCare,
        params?.interests.fnd,
        params?.interests.sports,
      ),
      name: params?.name,
      pronouns: params?.pronouns,
      showTruncatedName: params?.showTruncatedName,
      locationCoordinates: params?.locationCoordinates,
      showPronoun: params?.showPronoun,
      showDatingPreference: params?.showDatingPreference,
      showGender: params?.showGender,
      height: params?.height,
      hometown: params?.hometown,
      zodiac: params?.zodiac,
      languages: params?.languages,
      work: params?.work,
      lifeStyle: params?.lifeStyle,
      values: params?.values,
    );
  }
}
