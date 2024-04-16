import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
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
  })
}
    ''';


    final response = await service.performMutation(query, variables: {
      "id": "+919994361298",
      "phone":"+919994361298"
    });
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
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(
      OtpParams params,
      ) async {
    const query = '''
     mutation ValidateOTP(\$id: String!,\$phone: String!, \$otp: String!) {
  validateOTP(data: {
    id: \$id,
    phone: \$phone,
    otp: \$otp
  }) {
    accessToken
    refreshToken
  }
}
    ''';


    final response = await service.performMutation(query, variables: {

        "id": "+919994361298",
        "phone":"+919994361298",
        "otp": "893736222"

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
      return OperationFailure(error: response.exception);
    }
  }
}
