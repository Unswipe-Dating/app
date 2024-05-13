import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_param_and_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../../../../core/utils/usecases/usecase.dart';



@Injectable()
class UpdateProfileUseCase {
  final UpdateProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Stream<GetUpsertUserResponse>> buildUseCaseStream(String token,
      UpdateProfileParamAndResponse? params) async {
    final controller = StreamController<GetUpsertUserResponse>();
    try{
      if(params != null) {
        final result = await repository.upsertUser(token, params);
        controller.add(GetUpsertUserResponse(result));
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

class GetUpsertUserResponse {
  final ApiResponse<UpdateProfileParamAndResponse> val;

  GetUpsertUserResponse(this.val);
}
