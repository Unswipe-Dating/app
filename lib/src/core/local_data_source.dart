
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:unswipe/src/core/utils/constant/user_and_token_entity.dart';

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


  Stream<bool?> get onBoardingToken$;


  Single<void> saveOnBoardingToken(bool? onBoardingTokenEntity);

}

abstract class Crypto {
  Future<String> encrypt(String plaintext);

  Future<String> decrypt(String ciphertext);
}
