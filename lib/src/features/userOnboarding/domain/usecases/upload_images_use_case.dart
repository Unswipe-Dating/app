

import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/userOnboarding/data/models/upload_image_response/upload_image_response.dart';

import '../../../../../../data/api_response.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../repository/on_boarding_user_repository.dart';



@Injectable()
class UploadImageUseCase extends UseCase<GetUploadImagesResponse, Object> {
  final UserOnboardingRepository repository;

  UploadImageUseCase(this.repository);

  @override
  Future<Stream<GetUploadImagesResponse>> buildUseCaseStream(Object? params) async {
    final controller = StreamController<GetUploadImagesResponse>();
    try{
      if(params != null) {
        final result = await repository.uploadImages();
        controller.add(GetUploadImagesResponse(result));
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

class GetUploadImagesResponse {
  final ApiResponse<String> val;

  GetUploadImagesResponse(this.val);
}
