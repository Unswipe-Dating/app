import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import '../../../../../../../data/api_response.dart';
import '../../../../../../core/network/graphql/graphql_service.dart';
import '../../../domain/repository/image_upload_repository.dart';

@injectable
class ImageUploadService {
  ImageUploadService(this.service);

  final GraphQLService service;

  Future<ApiResponse<ResponseContactBlock>> blockContacts(String token,
      ImageUploadParams params,
      ) async {
    final query = '''
     mutation BlockUsers(\$id: String!, \$data: BlockUserInput!) {
  blockUsers(id: \$id, data: \$data)
}
    ''';


    final response = await service.performMutationWithHeader(token, query, variables: {
      "id": params.id,
      "data": {"phones" : params.data.phones},
    });
    log('$response');

    if (!response.hasException) {
      ResponseContactBlock? info;
      try {
        info = ResponseContactBlock.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      return OperationFailure(error: response.exception);
    }
  }

}
