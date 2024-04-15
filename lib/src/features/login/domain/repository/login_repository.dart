import 'dart:async';

import '../../../../../data/api_response.dart';
import '../../data/models/otp_response.dart';

abstract class LoginRepository {
  Future<ApiResponse<OtpResponse>> requestOtp(OtpParams otpParams);

}

class OtpParams {
  late final String phone;
  late final String id;
  OtpParams({
    required this.phone,
    required this.id,

  });
}
