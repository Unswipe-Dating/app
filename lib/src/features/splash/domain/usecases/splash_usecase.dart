import 'dart:async';

import 'package:unswipe/src/core/utils/usecases/usecase.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';
import '../../../../../data/api_response.dart';

class SplashUseCase extends UseCase<GetSplashUseCaseResponse, SplashParams> {
  final AbstractSplashRepository repository;

  SplashUseCase(this.repository);

  @override
  Future<Stream<GetSplashUseCaseResponse>> buildUseCaseStream(SplashParams? params) async {
    final controller = StreamController<GetSplashUseCaseResponse>();
    try{
      if(params != null) {
        final result = await repository.imitateInit(params);
        controller.add(GetSplashUseCaseResponse(result));
        logger.finest('GetSplashUseCaseResponse successful.');
        controller.close();
      } else {
        logger.severe('param is null');
        controller.addError(Exception());
      }
    } catch (e) {
      logger.severe('GetCharacterInfoUseCase failure: $e');
      controller.addError(e);
    }

    return controller.stream;
  }



}

class GetSplashUseCaseResponse {
  final ApiResponse<bool> val;

  GetSplashUseCaseResponse(this.val);
}