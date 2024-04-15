
import 'package:injectable/injectable.dart';

import '../../../core/app_error.dart';
import '../entities/auth_state.dart';
import '../repository/user_repository.dart';

@Injectable()
class GetAuthStateStreamUseCase {
  final UserRepository _userRepository;

  const GetAuthStateStreamUseCase(this._userRepository);

  Stream<Result<AuthenticationState>> call() =>
      _userRepository.authenticationState$;
}
