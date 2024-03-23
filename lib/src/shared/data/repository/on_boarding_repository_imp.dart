import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:unswipe/src/core/app_error.dart';
import 'package:unswipe/src/core/utils/constant/on_boarding_token_entity.dart';
import 'package:unswipe/src/shared/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:unswipe/src/shared/domain/repository/on_boarding_repository.dart';
import '../../../../data/exception/local_data_source_exception.dart';
import '../../../../data/exception/remote_data_source_exception.dart';
import '../../../core/cancellation_exception.dart';
import '../../../core/local_data_source.dart';

part 'onboarding_mappers.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  final LocalDataSource _localDataSource;

  @override
  final Stream<Result<OnBoardingState>> onboardingState$;

  OnBoardingRepositoryImpl(
      this._localDataSource,
      ) : onboardingState$ = _localDataSource.onBoardingToken$
      .map(_OnBoardingMappers.onBoardingEntityToDomainAuthState)
      .toEitherStream(_OnBoardingMappers.errorToAppError)
  {
    _init().ignore();
  }

  Future<void> _init() async {
    const tag = '[OnBoarding_Repository] { init }';

    try {
      final onBoardingToken = await _localDataSource.onBoardingToken$.first;

      if (onBoardingToken == null) {
        return;
      }

      await _localDataSource
          .saveOnBoardingToken(
        _OnBoardingMappers.userResponseToOnBoardingTokenEntity(
          onBoardingToken.token,
        ),
      )
          .first;
    } on RemoteDataSourceException catch (e) {
      debugPrint('$tag remote error=$e');
    } on LocalDataSourceException catch (e) {
      debugPrint('$tag local error=$e');
      await _localDataSource.removeUserAndToken().first;
    }
  }


}
