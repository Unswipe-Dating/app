

import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/signupOrLogin/signup_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';

import '../datasources/network/service/otp_service.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {

  final OtpService services;

  LoginRepositoryImpl(
      this.services,
      );
  @override
  Future<ApiResponse<OtpResponse>> requestOtp(OtpParams otpParams) async {
    final response = await services.requestOtp(otpParams);
    if (response is Success) {
      try {
        final result = (response as Success).data as OtpResponse;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }

  @override
  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(OtpParams otpParams) async {
      final response = await services.verifyOtp(otpParams);
      if (response is Success) {
        try {
          final result = (response as Success).data as VerifyOtpResponse;
          return Success(data: result);
        } on Exception catch (e, _) {
          return Failure(error: e);
        }
      } else {
        return Failure(error: Exception((response as Failure).error));
      }
    }

  @override
  Future<ApiResponse<SignUpResponse>> signUp(OtpParams otpParams) async {
    final response = await services.signupOrLogin(otpParams);
    if (response is Success) {
      try {
        final result = (response as Success).data as SignUpResponse;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }

}



