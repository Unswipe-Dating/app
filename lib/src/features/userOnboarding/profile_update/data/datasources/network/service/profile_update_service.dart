import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_param_and_response.dart';

import '../../../../../../../../data/api_response.dart';
import '../../../../../../../core/network/graphql/graphql_service.dart';


@injectable
class UpdateUserService {
  UpdateUserService(this.service);

  final GraphQLService service;

  Future<ApiResponse<UpdateProfileParamAndResponse>> upsertUser(String token,
      UpdateProfileParamAndResponse params,
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
      UpdateProfileParamAndResponse? info;
      try {
        info = UpdateProfileParamAndResponse.fromJson(
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
