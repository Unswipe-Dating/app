import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';

import '../../../../../data/api_response.dart';
import '../../../../../data/validations.dart';
import '../../../../core/utils/usecases/usecase.dart';

@Injectable()
class RequestOtpUseCase extends UseCase<GetOtpUseCaseResponse, OtpParams> {
  final LoginRepository repository;

  RequestOtpUseCase(this.repository);

  @override
  Future<Stream<GetOtpUseCaseResponse>> buildUseCaseStream(OtpParams? params) async {
    final controller = StreamController<GetOtpUseCaseResponse>();
    try{
      if(params != null) {
        final result = await repository.requestOtp(params);
        controller.add(GetOtpUseCaseResponse(result));
        logger.finest('GetSplashUseCaseResponse successful.');
        controller.close();
      } else {
        logger.severe('param is null');
        controller.addError(InvalidRequestException());
      }
    } catch (e) {
      logger.severe('GetCharacterInfoUseCase failure: $e');
      controller.addError(e);
    }

    return controller.stream;
  }



}

class GetOtpUseCaseResponse {
  final ApiResponse<OtpResponse> val;

  GetOtpUseCaseResponse(this.val);
}