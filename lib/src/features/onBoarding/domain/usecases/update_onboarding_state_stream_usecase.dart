import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/onBoarding/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:unswipe/src/shared/domain/repository/user_repository.dart';

import '../../../../core/app_error.dart';

@Injectable()
class UpdateOnboardingStateStreamUseCase {
  final UserRepository _onBoardingRepository;

  const UpdateOnboardingStateStreamUseCase(this._onBoardingRepository);

  VoidResultStream call(OnBoardingStatus status) {
    return _onBoardingRepository.updateOnBoardingState(status);
  }
}
