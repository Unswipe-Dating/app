import '../../../core/app_error.dart';
import '../repository/on_boarding_repository.dart';

class UpdateOnboardingStateStreamUseCase {
  final OnBoardingRepository _onBoardingRepository;

  const UpdateOnboardingStateStreamUseCase(this._onBoardingRepository);

  UnitResultSingle call() =>
      _onBoardingRepository.updateOnBoardingState();
}
