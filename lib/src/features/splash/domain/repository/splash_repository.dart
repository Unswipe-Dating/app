import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/splash/data/datasources/model/response_meta.dart';

abstract class SplashRepository {
  Future<ApiResponse<ResponseMeta>> getConfig(String token);


}