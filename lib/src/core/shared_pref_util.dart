import 'dart:async';
import 'dart:convert';

import 'package:unswipe/data/exception/local_data_source_exception.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:unswipe/src/core/utils/constant/user_and_token_entity.dart';

import 'local_data_source.dart';

class SharedPrefUtil implements LocalDataSource {
  static const _kUserTokenKey = 'com.hoc.unswipe2_flutter.user_and_token';
  final RxSharedPreferences _rxPrefs;
  final Crypto _crypto;

  const SharedPrefUtil(this._rxPrefs, this._crypto);

  @override
  Stream<void> saveUserAndToken(UserAndTokenEntity userAndToken) async*{
    await _rxPrefs
        .write<UserAndTokenEntity>(_kUserTokenKey, userAndToken, _toString)
        .onError<Object>((e, s) => throw LocalDataSourceException(
        'Cannot save user and token', e, s));
    yield null;
  }

  @override
  Stream<void> removeUserAndToken() => Single.fromCallable(
        () => _rxPrefs.remove(_kUserTokenKey).onError<Object>((e, s) =>
            throw LocalDataSourceException(
                'Cannot delete user and token', e, s)),
      );



  @override
  Stream<UserAndTokenEntity?> get userAndToken$ => _rxPrefs
      .observe<UserAndTokenEntity>(_kUserTokenKey, _toEntity)
      .onErrorReturnWith((e, s) =>
          throw LocalDataSourceException('Cannot read user and token', e, s));

  //
  // Encoder and Decoder
  //

  FutureOr<UserAndTokenEntity?> _toEntity(dynamic jsonString) =>
      jsonString == null
          ? null
          : _crypto
          .decrypt(jsonString as String)
          .then((s) => UserAndTokenEntity.fromJson(jsonDecode(s)));

  FutureOr<String?> _toString(UserAndTokenEntity? entity) =>
      entity == null ? null : _crypto.encrypt(jsonEncode(entity));




  }
