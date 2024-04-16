import 'dart:async';

import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';

import '../../../../../data/api_response.dart';
import '../../data/models/request_otp/otp_response.dart';

abstract class LoginRepository {
  Future<ApiResponse<OtpResponse>> requestOtp(OtpParams otpParams);
  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(OtpParams otpParams);


}

class OtpParams {
  late final String phone;
  late final String id;
  late final String otp;
  OtpParams({
    required this.phone,
    required this.id,
     this.otp = ""

  });
}
