
import 'package:dart_either/dart_either.dart';

import '../../network/error/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
