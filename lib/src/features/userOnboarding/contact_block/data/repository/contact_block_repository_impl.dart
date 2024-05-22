

import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';

import '../../domain/repository/contact_block_repository.dart';


@Injectable(as: ContactBlockRepository)
class ContactBlockRepositoryImpl implements ContactBlockRepository {

  final ContactBlockService services;

  ContactBlockRepositoryImpl(
      this.services,
      );
  @override
  Future<ApiResponse<ResponseContactBlock>> blockContacts(String token, ContactBlockParams params) async {
    final response = await services.blockContacts(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseContactBlock;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }


}

