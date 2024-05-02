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
  }) {
  orderId
  }
}
    ''';


    final response = await service.performMutation(query, variables: {
      "id": params.phone,
      "phone":params.phone
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
     mutation ValidateOTP(\$id: String!,\$phone: String!, \$otp: String!, \$otpOrderId: String!) {
  validateOTP(data: {
    id: \$id,
    phone: \$phone,
    otp: \$otp,
    otpOrderId: \$otpOrderId
  }) {
    accessToken
    refreshToken
  }
}
    ''';


    final response = await service.performMutation(query, variables: {

        "id": params.phone,
        "phone":params.phone,
        "otp": params.otp,
        "otpOrderId": params.otpOrderId

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
