import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/signupOrLogin/signup_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userProfile/domain/repository/profile_swipe_repository.dart';
import '../../../../../../../data/api_response.dart';
import '../../../../../core/network/graphql/graphql_service.dart';
import '../../../../userProfile/data/model/get_profile/response_profile_swipe.dart';

@injectable
class UserSettingService {
  UserSettingService(this.service);

  final GraphQLService service;

  Future<ApiResponse<ResponseProfileSwipe>> getProfile(String token,
    String id,
  ) async {
    final query = '''
     query userProfile(\$userId: String!) {
    userProfile(userId: \$userId){
       id
       userId
       name
       interests
       photoURLs
       location
       locationCoordinates
       dob
       datingPreference
       height
       hometown
       location
       zodiac
       languages
       pronouns
       gender
       showTruncatedName
    }
}
    ''';

    try {
      final response = await service.performMutationWithHeader(
          token, query, variables: {
        "userId": id,
      });
      log('$response');

      if (!response.hasException) {
        ResponseProfileSwipe? info;
        try {
          info = ResponseProfileSwipe.fromJson(
            response.data as Map<String, dynamic>,
          );
        } on Exception catch (e) {
          log('error', error: e);
          return Failure(error: Exception(e));
        }
        return Success(data: info);
      } else {
        if (response.exception?.graphqlErrors[0].extensions?['code'] ==
            "UNAUTHENTICATED") {
          return AuthorizationFailure(error: response.exception);
        }
        return OperationFailure(error: response.exception);
      }
    } on TimeOutFailure catch (_) {
      // todo: timeout failure
      return TimeOutFailure();
    }
  }
}
