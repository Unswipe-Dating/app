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

  VerifyOtpUseCase(this._repository);


  Future<Stream<VerifyOtpUseCaseResponse>> buildUseCaseStream(OtpParams? params) async {
    final controller = StreamController<VerifyOtpUseCaseResponse>();
    try{
      if(params != null) {
        final result = await _repository.verifyOtp(params);
        controller.add(VerifyOtpUseCaseResponse(result));
        controller.close();
      } else {
        controller.addError(Exception());
      }
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }

}

class VerifyOtpUseCaseResponse {
  final ApiResponse<VerifyOtpResponse> val;

  VerifyOtpUseCaseResponse(this.val);
}
