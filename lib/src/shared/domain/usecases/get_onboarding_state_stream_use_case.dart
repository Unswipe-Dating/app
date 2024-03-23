
import '../../../core/app_error.dart';
import '../entities/auth_state.dart';
import '../entities/onbaording_state/onboarding_state.dart';
import '../repository/on_boarding_repository.dart';
import '../repository/user_repository.dart';

class GetOnboardingStateStreamUseCase {
  final OnBoardingRepository _onBoardingRepository;

  const GetOnboardingStateStreamUseCase(this._onBoardingRepository);

  Stream<Result<OnBoardingState>> call() =>
      _onBoardingRepository.onboardingState$;
}
