import 'dart:developer';
import "package:http/http.dart";

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/image_upload/data/model/response_image_upload.dart';
import '../../../../../../../data/api_response.dart';
import '../../../../../../core/network/graphql/graphql_service.dart';
import '../../../domain/repository/image_upload_repository.dart';

@injectable
class ImageUploadService {
  ImageUploadService(this.service);

  final GraphQLService service;

  Future<ApiResponse<ResponseImageUpload>> blockContacts(
    String token,
    List<MultipartFile> files,
  ) async {
    final query = '''
   mutation UploadProfilePhotos(\$files:[Upload!]!) {
     uploadProfilePhotos(data: {
      files: \$files 
      })
     }
    ''';

    final response =
        await service.performMutationWithHeaderForUpload(token, query, variables: {
      "files": files,
    });
    log('$response');

    if (!response.hasException) {
      ResponseImageUpload? info;
      try {
        info = ResponseImageUpload.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }
}
