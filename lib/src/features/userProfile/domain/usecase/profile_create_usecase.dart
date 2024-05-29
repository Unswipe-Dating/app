import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';
import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';

import '../../../../../../data/api_response.dart';
import '../../data/model/get_profile/response_profile_swipe.dart';
import '../repository/profile_swipe_repository.dart';


@Injectable()
class ProfileCreateUseCase {
  final ProfileSwipeRepository _repository;
  BehaviorSubject<GetProfileCreateUseCaseResponse> controller = BehaviorSubject<GetProfileCreateUseCaseResponse>();


  ProfileCreateUseCase(this._repository);
  FutureOr<void> buildUseCaseStream(String token,
      ProfileSwipeParams? params) async {
    try{
      if(params != null) {
        final result = await _repository.createRequest(token, params);
        controller.add(GetProfileCreateUseCaseResponse(result));
      } else {
        controller.addError(Exception());
      }
    } catch (e) {
      controller.addError(e);
    }
  }

}



class GetProfileCreateUseCaseResponse {
  final ApiResponse<ResponseProfileRequest> val;

  GetProfileCreateUseCaseResponse(this.val);
}