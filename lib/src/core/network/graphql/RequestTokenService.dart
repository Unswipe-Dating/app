import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/signupOrLogin/signup_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import '../../../../../../../data/api_response.dart';
import 'graphql_service.dart';

@injectable
class RequestTokenService {
  RequestTokenService(this.service);

  final GraphQLService service;

  Future<ApiResponse<SignUpResponse>> refreshToken(
      String token,
      String userId
      ) async {
    const query = '''
   mutation refreshToken(\$token: String!,\$userId: String!) {
  refreshToken(data: {
    token: \$token,
    userId: \$userId
  }) {
    accessToken
    refreshToken
  }
}
    ''';

    try {
      final response = await service.performMutation(query, variables: {
        "token": token,
        "userId": userId,
      });
      log('$response');

      if (!response.hasException) {
        SignUpResponse? info;
        try {
          info = SignUpResponse.fromJson(
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
