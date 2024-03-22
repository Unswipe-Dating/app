

import 'dart:ffi';

import 'package:dart_either/dart_either.dart';
import 'package:unswipe/src/core/network/error/exceptions.dart';
import 'package:unswipe/src/core/network/error/failures.dart';
import 'package:unswipe/src/core/preference.dart';
import 'package:unswipe/src/features/splash/data/datasources/local/splash_shared_pref.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';


class SplashRepositoryImpl extends AbstractSplashRepository {
  final SplashSharedPref pref;

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