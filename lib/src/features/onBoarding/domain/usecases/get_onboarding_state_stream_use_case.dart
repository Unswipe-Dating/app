
import 'package:injectable/injectable.dart';

import '../../../../core/app_error.dart';
import '../entities/onbaording_state/onboarding_state.dart';
import '../../../../shared/domain/repository/user_repository.dart';

@injectable
class GetOnboardingStateStreamUseCase {
  final UserRepository _onBoardingRepository;

  const GetOnboardingStateStreamUseCase(this._onBoardingRepository);

  Stream<Result<OnBoardingState>> call() =>
      _onBoardingRepository.onboardingState$;
}
