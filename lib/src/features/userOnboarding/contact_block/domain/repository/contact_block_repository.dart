import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';

import '../../../../../../data/api_response.dart';

abstract class ContactBlockRepository {
  Future<ApiResponse<ResponseContactBlock>> blockContacts(String token,
      ContactBlockParams params);


}

class ContactBlockParams {
  late final BlockContactDataParams data;
  late final String id;


  ContactBlockParams({
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