import 'dart:io';

import '../../../core/app_error.dart';
import '../entities/auth_state.dart';
import '../entities/onbaording_state/onboarding_state.dart';



abstract class UserRepository {
  Stream<Result<AuthenticationState>> get authenticationState$;
  Stream<Result<OnBoardingState>> get onboardingState$;
  VoidResultStream updateOnBoardingState();

}
