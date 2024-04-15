

import 'dart:ffi';

import 'package:dart_either/dart_either.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';

abstract class AbstractSplashRepository {
  // getting first time user api calls
  Future<ApiResponse<bool>> imitateInit(SplashParams params);

}