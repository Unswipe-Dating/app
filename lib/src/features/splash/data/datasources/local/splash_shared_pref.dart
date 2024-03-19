import 'package:shared_preferences/shared_preferences.dart';

class SplashSharedPref {
  final SharedPreferences _preferences;

  SplashSharedPref(this._preferences);

  /// __________ Clear Storage __________ ///
  Future<bool> clearAllLocalData() async {
    return true;
  }
}
