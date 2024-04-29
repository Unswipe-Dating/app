import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/models/block_contact/block_contact_response.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/on_boarding_user_repository.dart';

import '../../../../../../data/api_response.dart';
import '../../../../../core/utils/usecases/usecase.dart';



@Injectable()
class BlockContactUseCase extends UseCase<GetBlockUsersResponse, Object> {
  final UserOnboardingRepository repository;

  BlockContactUseCase(this.repository);

  @override
  Future<Stream<GetBlockUsersResponse>> buildUseCaseStream(Object? params) async {
    final controller = StreamController<GetBlockUsersResponse>();
    try{
      if(params != null) {
        final result = await repository.blockUsers();
        controller.add(GetBlockUsersResponse(result));
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

class GetBlockUsersResponse {
  final ApiResponse<BlockContactResponse> val;

  GetBlockUsersResponse(this.val);
}
