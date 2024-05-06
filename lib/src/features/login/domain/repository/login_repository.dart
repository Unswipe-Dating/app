import 'dart:async';

import 'package:unswipe/src/core/app_error.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/usecases/verify_otp_use_case.dart';

import '../../../../../data/api_response.dart';
import '../../data/models/request_otp/otp_response.dart';
import '../usecases/request_otp_use_case.dart';

abstract class LoginRepository {
  TResultStream<GetOtpUseCaseResponse>requestOtp(OtpParams otpParams);
  TResultStream<VerifyOtpUseCaseResponse> verifyOtp(OtpParams otpParams);


}

class OtpParams {
  late final String phone;
  late final String id;
  late final String otp;
  late final String otpOrderId;

  OtpParams({
    required this.phone,
    required this.id,
     this.otp = "",
    this.otpOrderId = ""
  });
}
