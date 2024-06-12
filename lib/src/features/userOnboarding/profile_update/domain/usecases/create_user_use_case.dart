import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../../../../core/utils/usecases/usecase.dart';
import '../../data/models/create_profile_response.dart';



@Injectable()
class CreateProfileUseCase {
  final UpdateProfileRepository repository;

  CreateProfileUseCase(this.repository);

  Future<Stream<GetCreateUserResponse>> buildUseCaseStream(String token,
      UpdateProfileParams? params) async {
    final controller = StreamController<GetCreateUserResponse>();
    try{
      if(params != null) {
        final result = await repository.createUser(token, params);
        controller.add(GetCreateUserResponse(result));
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

class GetCreateUserResponse {
  final ApiResponse<CreateProfileResponse> val;

  GetCreateUserResponse(this.val);
}
