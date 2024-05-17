import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/create_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';

import '../../../../../../../../data/api_response.dart';
import '../../../../../../../core/network/graphql/graphql_service.dart';
import '../../../../domain/repository/update_profile_repository.dart';

@injectable
class UpdateUserService {
  UpdateUserService(this.service);

  final GraphQLService service;

  Future<ApiResponse<UpdateProfileResponse>> updateUser(
    String token,
      UpdateProfileParams params,
  ) async {
    const query ='''
    mutation UpdateProfile(
  \$userId: String!,
  \$completed: Boolean,
  \$datingPreference: DatingPreference,
  \$dob: String,
  \$gender: DatingPreference,
  \$id: String,
  \$interests: JSONObject,
  \$name: String,
  \$pronouns: String,
  \$hometown: String,
  \$height: String,
  \$location: String,
  \$locationCoordinates: [String!],
  \$zodiac: ZodiacSign,
  \$showTruncatedName: Boolean){
  updateProfile(data: {
    userId: \$userId,
    completed: \$completed,
    datingPreference: \$datingPreference,
    dob: \$dob,
    gender: \$gender,
    id: \$id,
    interests: \$interests,
    name: \$name,
    pronouns: \$pronouns,
    showTruncatedName: \$showTruncatedName,
    hometown:  \$hometown,
    height: \$height,
    location: \$location,
    locationCoordinates:\$locationCoordinates,
    zodiac: \$zodiac
  }) {
    userId
    completed
    datingPreference
    dob
    gender
    id
    interests
    name
    pronouns
    showTruncatedName
    hometown
    height
    location
    locationCoordinates
    zodiac
  }
}
    ''';

    final response =
        await service.performMutationWithHeader(token, query, variables: {});
    log('$response');

    if (!response.hasException) {
      UpdateProfileResponse? info;
      try {
        info = UpdateProfileResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<CreateProfileResponse>> createUser(
      String token,
      UpdateProfileParams params,
      ) async {
    const query ='''
    mutation CreateProfile(
  \$userId: String!,
  \$completed: Boolean,
  \$datingPreference: DatingPreference,
  \$dob: String,
  \$gender: DatingPreference,
  \$id: String,
  \$interests: JSONObject,
  \$name: String,
  \$pronouns: String,
  \$hometown: String,
  \$height: String,
  \$location: String,
  \$locationCoordinates: [String!],
  \$zodiac: ZodiacSign,
  \$showTruncatedName: Boolean){
  createProfile(data: {
    userId: \$userId,
    completed: \$completed,
    datingPreference: \$datingPreference,
    dob: \$dob,
    gender: \$gender,
    id: \$id,
    interests: \$interests,
    name: \$name,
    pronouns: \$pronouns,
    showTruncatedName: \$showTruncatedName,
    hometown:  \$hometown,
    height: \$height,
    location: \$location,
    locationCoordinates:\$locationCoordinates,
    zodiac: \$zodiac
  }) {
    userId
    completed
    datingPreference
    dob
    gender
    id
    interests
    name
    pronouns
    showTruncatedName
    hometown
    height
    location
    locationCoordinates
    zodiac
  }
}
    ''';

    final response =
    await service.performMutationWithHeader(token, query, variables: {
      "userId": params.userId,
      "datingPreference": params.datingPreference,
      "dob": params.dob,
      "gender": params.gender,
      "id": params.id,
      "interests": params.interests,
      "name": params.name,
      "pronouns": params.pronouns,
      "showTruncatedName": params.showTruncatedName
    });
    log('$response');

    if (!response.hasException) {
      CreateProfileResponse? info;
      try {
        info = CreateProfileResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      return OperationFailure(error: response.exception);
    }
  }
}
