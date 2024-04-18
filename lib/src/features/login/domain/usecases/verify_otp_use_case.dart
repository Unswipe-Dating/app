import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';

import '../../../../../data/api_response.dart';
import '../../../../core/utils/usecases/usecase.dart';

@Injectable()
class VerifyOtpUseCase extends UseCase<VerifyOtpUseCaseResponse, OtpParams> {
  final LoginRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Stream<VerifyOtpUseCaseResponse>> buildUseCaseStream(OtpParams? params) async {
    final controller = StreamController<VerifyOtpUseCaseResponse>();
    try{
      if(params != null) {
        final result = await repository.verifyOtp(params);
        controller.add(VerifyOtpUseCaseResponse(result));
        logger.finest('GetSplashUseCaseResponse successful.');
        controller.close();
      } else {
        logger.severe('param is null');
        controller.addError(Exception());
      }
    } catch (e) {
      logger.severe('GetCharacterInfoUseCase failure: $e');
      controller.addError(e);
    }

    return controller.stream;
  }



}

class VerifyOtpUseCaseResponse {
  final ApiResponse<VerifyOtpResponse> val;

  VerifyOtpUseCaseResponse(this.val);
}
