import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_param_and_response.dart';

import '../../../../../../../../data/api_response.dart';
import '../../../../../../../core/network/graphql/graphql_service.dart';
import '../../../../domain/repository/update_profile_repository.dart';

@injectable
class UpdateUserService {
  UpdateUserService(this.service);

  final GraphQLService service;

  Future<ApiResponse<UpdateProfileParamAndResponse>> upsertUser(
    String token,
      UpdateProfileParams params,
  ) async {
    const query = '''
    mutation UpsertProfile(
  \$userId: String!
  \$completed: Boolean,
  \$datingPreference: DatingPreference,
  \$dob: String,
  \$gender: DatingPreference,
  \$id: String,
  \$interests: String,
  \$name: String,
  \$pronouns: String,
  \$showTruncatedName: Boolean){
  upsertProfile(data: {
    id: \$id,
    completed: \$completed,
    datingPreference: \$datingPreference,
    dob: \$dob,
    gender: \$gender,
    interests: \$interests,
    name: \$name,
    pronouns: \$pronouns,
    showTruncatedName: \$showTruncatedName,
    userId: \$userId
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
  }
}
''';

    final response =
        await service.performMutationWithHeader(token, query, variables: {});
    log('$response');

    if (!response.hasException) {
      UpdateProfileParamAndResponse? info;
      try {
        info = UpdateProfileParamAndResponse.fromJson(
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
