

import 'dart:ffi';

import 'package:dart_either/dart_either.dart';
import 'package:unswipe/src/core/network/error/exceptions.dart';
import 'package:unswipe/src/core/preference.dart';
import 'package:unswipe/src/features/splash/data/datasources/local/splash_shared_pref.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';

import '../../../../../data/api_response.dart';


class SplashRepositoryImpl extends AbstractSplashRepository {
  final SplashSharedPref pref;

  SplashRepositoryImpl(
      this.pref
      );

  @override
  Future<ApiResponse<bool>> imitateInit(SplashParams params) async {

    try {
      final result = await pref.getBool("key", defaultValue: false);
      return Success( data: result);
    } on ServerException catch (e) {
      return Failure(error: e);
    }
  }




}