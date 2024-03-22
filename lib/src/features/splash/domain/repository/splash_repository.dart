

import 'dart:ffi';

import 'package:dart_either/dart_either.dart';
import 'package:unswipe/src/core/network/error/failures.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';

abstract class AbstractSplashRepository {
  // getting first time user api calls
  Future<Either<Failure,  bool>> imitateInit(SplashParams params);
  Future<Either<Failure,  bool>> imitateAuth(SplashParams params);

}