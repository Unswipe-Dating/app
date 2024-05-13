import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';

import '../../../../../../data/api_response.dart';


@Injectable()
class ContactBlockUseCase {
  final ContactBlockRepository _repository;

  ContactBlockUseCase(this._repository);


  Future<Stream<GetBlockContactsUseCaseResponse>> buildUseCaseStream(String token,
      ContactBlockParams? params) async {
    final controller = StreamController<GetBlockContactsUseCaseResponse>();
    try{
      if(params != null) {
        final result = await _repository.blockContacts(token, params);
        controller.add(GetBlockContactsUseCaseResponse(result));
        controller.close();
      } else {
        controller.addError(Exception());
      }
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }

}



class GetBlockContactsUseCaseResponse {
  final ApiResponse<ResponseContactBlock> val;

  GetBlockContactsUseCaseResponse(this.val);
}