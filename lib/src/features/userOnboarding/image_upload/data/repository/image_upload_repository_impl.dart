

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';

import '../../domain/repository/image_upload_repository.dart';
import '../datasources/network/image_upload_service.dart';
import '../model/response_image_upload.dart';



@Injectable(as: ImageUploadRepository)
class ImageUploadRepositoryImpl implements ImageUploadRepository {

  final ImageUploadService services;

  ImageUploadRepositoryImpl(
      this.services,
      );
  @override
  Future<ApiResponse<ResponseImageUpload>> uploadImages(String token, List<MultipartFile> params) async {
    final response = await services.blockContacts(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseImageUpload;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is AuthorizationFailure) {
      return AuthorizationFailure(
          error: (response as AuthorizationFailure).error);
    } else if (response is AuthorizationFailure) {
      return AuthorizationFailure(
          error: (response as AuthorizationFailure).error);
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }


}

