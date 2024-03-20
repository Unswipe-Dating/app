

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:unswipe/src/core/network/error/exceptions.dart';
import 'package:unswipe/src/core/network/error/failures.dart';
import 'package:unswipe/src/core/preference.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';


class SplashRepositoryImpl extends AbstractSplashRepository {
  final Preference pref;

  SplashRepositoryImpl(
      this.pref
      );

  @override
  Future<Either<Failure, bool>> imitateInit(SplashParams params) async {
    try {
      final result = await pref.getBool("key", defaultValue: false);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> imitateAuth(SplashParams params) async{
    try {
      final result = await pref.getBool("auth", defaultValue: false);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }



}