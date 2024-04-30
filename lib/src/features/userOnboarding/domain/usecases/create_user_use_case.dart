import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/userOnboarding/data/models/block_contact/block_contact_response.dart';
import 'package:unswipe/src/features/userOnboarding/domain/entities/create_user_request.dart';
import 'package:unswipe/src/features/userOnboarding/domain/repository/on_boarding_user_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../../../core/utils/usecases/usecase.dart';



@Injectable()
class CreateUserUseCase extends UseCase<GetCreateUserResponse, CreateUserRequest> {
  final UserOnboardingRepository repository;

  CreateUserUseCase(this.repository);

  @override
  Future<Stream<GetCreateUserResponse>> buildUseCaseStream(CreateUserRequest? params) async {
    final controller = StreamController<GetCreateUserResponse>();
    try{
      if(params != null) {
        final result = await repository.createUser(params);
        controller.add(GetCreateUserResponse(result));
        logger.finest('GetSplashUseCaseResponse successful.');
        controller.close();
      } else {
        logger.severe('param is null');
        controller.addError(Exception());
      }
    } catch (e) {
      logger.severe('GetCharacterInfoUseCase failure: $e');
      controller.addError(e);
    }

    return controller.stream;
  }



}

class GetCreateUserResponse {
  final ApiResponse<String> val;

  GetCreateUserResponse(this.val);
}
