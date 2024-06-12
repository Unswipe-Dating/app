
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:unswipe/src/core/app_error.dart';
import 'package:unswipe/src/core/utils/constant/user_and_token_entity.dart';
import 'package:unswipe/src/features/onBoarding/domain/entities/onbaording_state/onboarding_state.dart';

abstract class LocalDataSource {
  /// Returns a single-subscription stream that emits [UserAndTokenEntity] or null
  Stream<UserAndTokenEntity?> get userAndToken$;

  /// Returns a future that completes with a [UserAndTokenEntity] value or null

  /// Save [userAndToken] into local storage.
  /// Throws [LocalDataSourceException] if saving is failed
  Stream<void> saveUserAndToken(UserAndTokenEntity userAndToken);

  /// Remove user and token from local storage.
  /// Throws [LocalDataSourceException] if removing is failed
  Stream<void> removeUserAndToken();


  Stream<OnBoardingStatus?> get onBoardingToken$;


  Stream<void> saveOnBoardingToken(OnBoardingStatus? onBoardingTokenEntity);

}

abstract class Crypto {
  Future<String> encrypt(String plaintext);

  Future<String> decrypt(String ciphertext);
}
