import 'dart:async';

import 'package:unswipe/src/features/login/data/models/signupOrLogin/signup_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';

import '../../../../../data/api_response.dart';
import '../../data/models/request_otp/otp_response.dart';

abstract class LoginRepository {
  Future<ApiResponse<OtpResponse>> requestOtp(OtpParams otpParams);
  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(OtpParams otpParams);
  Future<ApiResponse<SignUpResponse>> signUp(OtpParams otpParams);


}

class OtpParams {
   final String phone;
   final String id;
   final String otp;
   final String otpOrderId;
   final String fcmRegisterationToken;
   final String token;

  OtpParams({
    required this.phone,
    required this.id,
    this.otp = "",
    this.token = "",
    this.otpOrderId = "",
    this.fcmRegisterationToken = ""
  });
}
