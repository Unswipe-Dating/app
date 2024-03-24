
import '../../../core/app_error.dart';
import '../entities/onbaording_state/onboarding_state.dart';
import '../repository/user_repository.dart';

class GetOnboardingStateStreamUseCase {
  final UserRepository _onBoardingRepository;

  const GetOnboardingStateStreamUseCase(this._onBoardingRepository);

  Stream<Result<OnBoardingState>> call() =>
      _onBoardingRepository.onboardingState$;
}
