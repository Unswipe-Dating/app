

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:unswipe/src/core/network/error/exceptions.dart';
import 'package:unswipe/src/core/network/error/failures.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl extends AbstractSplashRepository {
  @override
  Future<Either<Failure, bool>> imitateInit(SplashParams params) async {
    try {
      await await Future.delayed(const Duration(milliseconds: 500));
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }



}