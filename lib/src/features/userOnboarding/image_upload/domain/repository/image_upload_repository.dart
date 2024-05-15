
import 'package:http/http.dart';

import '../../../../../../data/api_response.dart';
import '../../data/model/response_image_upload.dart';

abstract class ImageUploadRepository {
  Future<ApiResponse<ResponseImageUpload>> uploadImages(String token,
      List<MultipartFile> params);


}

class ImageUploadParams {
  late final BlockContactDataParams data;
  late final String id;


  ImageUploadParams({
    required this.data,
    required this.id,
  });
}

  class BlockContactDataParams {
  late final List<String> phones;


  BlockContactDataParams({
  required this.phones,
  });
}