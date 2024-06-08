import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';
import '../../../../../../../data/api_response.dart';
import '../../../../../core/network/graphql/graphql_service.dart';

@injectable
class MetaService {
  MetaService(this.service);

  final GraphQLService service;

  Future<ApiResponse<ResponseMeta>> getMeta(String token
      ) async {
    final query = '''
    query GetConfig {
    getConfig 
}
''';




    try {
      final response = await service.performMutationWithHeader(
          token, query, variables: {});
      log('$response');

      if (!response.hasException) {
        ResponseMeta? info;
        try {
          info = ResponseMeta.fromJson(
            response.data as Map<String, dynamic>,
          );
        } on Exception catch (e) {
          log('error', error: e);
          return Failure(error: Exception(e));
        }
        return Success(data: info);
      } else {
        if (response.exception?.graphqlErrors[0].extensions?['code'] ==
            "UNAUTHENTICATED") {
          return AuthorizationFailure(error: response.exception);
        }
        return OperationFailure(error: response.exception);
      }
    } on OperationFailure catch (_) {
      // todo: timeout failure
      return OperationFailure();

    }
  }


}
