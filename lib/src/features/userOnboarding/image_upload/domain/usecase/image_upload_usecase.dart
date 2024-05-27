import 'dart:async';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';
import 'package:unswipe/src/features/userOnboarding/image_upload/data/model/response_image_upload.dart';
import 'package:unswipe/src/features/userOnboarding/image_upload/domain/repository/image_upload_repository.dart';
import "package:http_parser/http_parser.dart" show MediaType;
import '../../../../../../data/api_response.dart';
import '../../presentation/widgets/multi_image_picker_files/image_file.dart';


@Injectable()
class ImageUploadUseCase {
  final ImageUploadRepository _repository;

  ImageUploadUseCase(this._repository);


  Future<Stream<UploadImageUseCaseResponse>> buildUseCaseStream(String token,
      List<MultipartFile> files) async {
    final controller = StreamController<UploadImageUseCaseResponse>();
    try{
      if(files != null) {
        final result = await _repository.uploadImages(token, files);
        controller.add(UploadImageUseCaseResponse(result));
      } else {
        controller.addError(Exception());
      }
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }

}





class UploadImageUseCaseResponse {
  final ApiResponse<ResponseImageUpload> val;

  UploadImageUseCaseResponse(this.val);
}