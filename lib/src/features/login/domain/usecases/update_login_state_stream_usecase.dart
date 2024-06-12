

import 'package:injectable/injectable.dart';

import '../../../../core/app_error.dart';
import '../../../../shared/domain/repository/user_repository.dart';

@Injectable()
class UpdateUserStateStreamUseCase {
  final UserRepository _userRepository;

  const UpdateUserStateStreamUseCase(this._userRepository);

  VoidResultStream call(String token, String id, String? userId) =>
      _userRepository.updateAuthenticationState(token, id, userId);
}
