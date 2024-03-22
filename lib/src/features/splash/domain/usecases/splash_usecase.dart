

import 'package:dart_either/dart_either.dart';
import 'package:unswipe/src/core/network/error/failures.dart';
import 'package:unswipe/src/core/utils/usecases/usecase.dart';
import 'package:unswipe/src/features/splash/domain/entities/splash_params.dart';
import 'package:unswipe/src/features/splash/domain/repository/splash_repository.dart';

class SplashUseCase extends UseCase<bool, SplashParams> {
  final AbstractSplashRepository repository;

  SplashUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SplashParams params) async {
    /*todo: right was async*/
    final result = await repository.imitateInit(params);
    return result.fold(ifLeft: (l) {
      return Left(l);
    }, ifRight:  (r) {
      return Right(r);
    });



  }

}