import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/settings/domain/repository/user_settings_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../../userProfile/data/model/get_profile/response_profile_swipe.dart';


@Injectable()
class GetSettingsProfileUseCase {
  final UserSettingsRepository _repository;

  GetSettingsProfileUseCase(this._repository);


  Future<Stream<GetSettingsProfileUseCaseResponse>> buildUseCaseStream(String? token, String id) async {
    final controller = StreamController<GetSettingsProfileUseCaseResponse>();
    try{
      if(token != null) {
        final result = await _repository.getProfile(token, id);
        controller.add(GetSettingsProfileUseCaseResponse(result));
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



class GetSettingsProfileUseCaseResponse {
  final ApiResponse<ResponseProfileSwipe> val;

  GetSettingsProfileUseCaseResponse(this.val);
}