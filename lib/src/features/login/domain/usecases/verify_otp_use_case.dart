import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';

import '../../../../../data/api_response.dart';
import '../../../../core/app_error.dart';
import '../../../../core/utils/usecases/usecase.dart';

@Injectable()
class VerifyOtpUseCase {
  final LoginRepository _repository;



  TResultStream<VerifyOtpUseCaseResponse> call(OtpParams params) =>
      _repository.verifyOtp(params);

  VerifyOtpUseCase(this._repository);

}

class VerifyOtpUseCaseResponse {
  final ApiResponse<VerifyOtpResponse> val;

  VerifyOtpUseCaseResponse(this.val);
}
