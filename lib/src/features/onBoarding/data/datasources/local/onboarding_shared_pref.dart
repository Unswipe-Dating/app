import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingSharedPref {
  final SharedPreferences _preferences;

  OnBoardingSharedPref(this._preferences);

  /// __________ Clear Storage __________ ///
  Future<bool> clearAllLocalData() async {
    return true;
  }
}
