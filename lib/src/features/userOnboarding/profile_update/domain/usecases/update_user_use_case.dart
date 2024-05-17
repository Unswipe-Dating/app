import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../../../../core/utils/usecases/usecase.dart';



@Injectable()
class UpdateProfileUseCase {
  final UpdateProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Stream<GetUpdateUserResponse>> buildUseCaseStream(String token,
      UpdateProfileParams? params) async {
    final controller = StreamController<GetUpdateUserResponse>();
    try{
      if(params != null) {
        final result = await repository.updateUser(token, params);
        controller.add(GetUpdateUserResponse(result));
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

class GetUpdateUserResponse {
  final ApiResponse<UpdateProfileResponse> val;

  GetUpdateUserResponse(this.val);
}

