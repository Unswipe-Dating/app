import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/signupOrLogin/signup_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import '../../../../../../../data/api_response.dart';
import '../../../../../../core/network/graphql/graphql_service.dart';

@injectable
class OtpService {
  OtpService(this.service);

  final GraphQLService service;

  Future<ApiResponse<OtpResponse>> requestOtp(
    OtpParams params,
  ) async {
    final query = '''
      mutation RequestOTP(\$id: String!,\$phone: String!) {
  requestOTP(data: {
    id: \$id,
    phone: \$phone,
  }) {
  orderId
  }
}
    ''';

    try {
      final response = await service.performMutation(query,
          variables: {"id": params.phone, "phone": params.phone});
      log('$response');

      if (!response.hasException) {
        OtpResponse? info;
        try {
          info = OtpResponse.fromJson(
            response.data as Map<String, dynamic>,
          );
        } on Exception catch (e) {
          log('error', error: e);
          return Failure(error: Exception(e));
        }
        return Success(data: info);
      } else {
        if(response.source?.name == "network") {
          return NoNetworkFailure();
        } else if (response.exception?.graphqlErrors[0].extensions?['code'] ==
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

  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(
    OtpParams params,
  ) async {
    const query = '''
     mutation ValidateOTP(
     \$id: String!,
     \$phone: String!,
     \$otp: String!,
     \$otpOrderId: String!,
     \$fcmRegisterationToken: String!
) {
  validateOTP(data: {
    id: \$id,
    phone: \$phone,
    otp: \$otp,
    otpOrderId: \$otpOrderId
    fcmRegisterationToken: \$fcmRegisterationToken

  }) {
    accessToken
    refreshToken
  }
}
    ''';

    try {
      final response = await service.performMutation(query, variables: {
        "id": params.phone,
        "phone": params.phone,
        "otp": params.otp,
        "otpOrderId": params.otpOrderId,
        "fcmRegisterationToken": params.fcmRegisterationToken
      });
      log('$response');

      if (!response.hasException) {
        VerifyOtpResponse? info;
        try {
          info = VerifyOtpResponse.fromJson(
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

  Future<ApiResponse<SignUpResponse>> signupOrLogin(
    OtpParams params,
  ) async {
    const query = '''
   mutation Signup(\$id: String!,\$phone: String!) {
  signup(data: {
    id: \$id,
    phone: \$phone
  }) {
    accessToken
    refreshToken
    user {
        id
        profileId
        firebaseCustomToken
    }
  }
}
    ''';

    try {
      final response = await service.performMutation(query, variables: {
        "id": params.phone,
        "phone": params.phone,
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
