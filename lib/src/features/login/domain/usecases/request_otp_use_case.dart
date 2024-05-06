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



  TResultStream<GetOtpUseCaseResponse> call(OtpParams params) =>
      _repository.requestOtp(params);

  RequestOtpUseCase(this._repository);

}



class GetOtpUseCaseResponse {
  final ApiResponse<OtpResponse> val;

  GetOtpUseCaseResponse(this.val);
}
