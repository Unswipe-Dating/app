import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../data/model/response_profile_swipe.dart';
import '../repository/profile_swipe_repository.dart';


@Injectable()
class ProfileSwipeUseCase {
  final ProfileSwipeRepository _repository;

  ProfileSwipeUseCase(this._repository);


  Future<Stream<GetProfileSwipeUseCaseResponse>> buildUseCaseStream(String token,
      ProfileSwipeParams? params) async {
    final controller = StreamController<GetProfileSwipeUseCaseResponse>();
    try{
      if(params != null) {
        final result = await _repository.getProfiles(token, params);
        controller.add(GetProfileSwipeUseCaseResponse(result));
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



class GetProfileSwipeUseCaseResponse {
  final ApiResponse<ResponseProfileSwipe> val;

  GetProfileSwipeUseCaseResponse(this.val);
}