import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:unswipe/src/shared/domain/repository/user_repository.dart';

import '../../../../core/app_error.dart';

@Injectable()
class ResetUserTokenStateStreamUseCase {
  final UserRepository _onBoardingRepository;

  const ResetUserTokenStateStreamUseCase(this._onBoardingRepository);

  VoidResultStream call() {
    return _onBoardingRepository.resetAuthState();
  }
}
