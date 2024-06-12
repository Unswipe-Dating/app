import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:unswipe/src/core/utils/usecases/usecase.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';
import '../../../../../data/api_response.dart';

@Injectable()
class MetaUseCase {
  final SplashRepository repository;

  MetaUseCase(this.repository);

  Future<Stream<GetMetaUseCaseResponse>> buildUseCaseStream(String? token) async {
    final controller = StreamController<GetMetaUseCaseResponse>();
    try{
      if(token != null) {
        final result = await repository.getConfig(token);
        controller.add(GetMetaUseCaseResponse(result));
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

class GetMetaUseCaseResponse {
  final ApiResponse<ResponseMeta> val;

  GetMetaUseCaseResponse(this.val);
}