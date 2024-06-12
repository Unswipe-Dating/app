import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';

import '../../../../../data/api_response.dart';
import '../../../../core/app_error.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/signupOrLogin/signup_response.dart';

@Injectable()
class SignUpUseCase {


  final LoginRepository _repository;

  SignUpUseCase(this._repository);


  Future<Stream<SignUpUseCaseResponse>> buildUseCaseStream(OtpParams? params) async {
    final controller = StreamController<SignUpUseCaseResponse>();
    try{
      if(params != null) {
        final result = await _repository.signUp(params);
        controller.add(SignUpUseCaseResponse(result));
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

class SignUpUseCaseResponse {
  final ApiResponse<SignUpResponse> val;

  SignUpUseCaseResponse(this.val);
}
