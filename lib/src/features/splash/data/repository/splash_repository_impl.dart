import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';
import '../../../../../data/api_response.dart';
import '../datasources/remote/meta_api_service.dart';

@Injectable(as: SplashRepository)
class SplashRepositoryImpl extends SplashRepository {
  final MetaService service;

  SplashRepositoryImpl(
      this.service,
      );

  @override
  Future<ApiResponse<ResponseMeta>> getConfig(String token) async {

    final response = await service.getMeta(token);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseMeta;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
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