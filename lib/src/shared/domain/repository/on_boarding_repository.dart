

import 'package:dart_either/dart_either.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:unswipe/src/shared/domain/entities/onbaording_state/onboarding_state.dart';

import '../../../core/app_error.dart';

abstract class OnBoardingRepository {
  Stream<Result<OnBoardingState>> get onboardingState$;
  UnitResultSingle updateOnBoardingState();

}