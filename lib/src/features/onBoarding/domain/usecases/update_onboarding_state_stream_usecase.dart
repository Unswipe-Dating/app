import 'package:unswipe/src/shared/domain/repository/user_repository.dart';

import '../../../../core/app_error.dart';

class UpdateOnboardingStateStreamUseCase {
  final UserRepository _onBoardingRepository;

  const UpdateOnboardingStateStreamUseCase(this._onBoardingRepository);

  VoidResultStream call() =>
      _onBoardingRepository.updateOnBoardingState();
}
