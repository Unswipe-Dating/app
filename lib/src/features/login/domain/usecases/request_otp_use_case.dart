import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';

import '../../../../../data/api_response.dart';
import '../../../../core/app_error.dart';
import '../../../../core/utils/usecases/usecase.dart';

@Injectable()
class RequestOtpUseCase {
  final LoginRepository _repository;

  RequestOtpUseCase(this._repository);


  Future<Stream<GetOtpUseCaseResponse>> buildUseCaseStream(OtpParams? params) async {
    final controller = StreamController<GetOtpUseCaseResponse>();
    try{
      if(params != null) {
        final result = await _repository.requestOtp(params);
        controller.add(GetOtpUseCaseResponse(result));
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



class GetOtpUseCaseResponse {
  final ApiResponse<OtpResponse> val;

  GetOtpUseCaseResponse(this.val);
}
