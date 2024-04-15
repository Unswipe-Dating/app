import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/constant/local_storage_constants.dart';

class AppSharedPrefs {

  AppSharedPrefs._();

  static final AppSharedPrefs _instance = AppSharedPrefs._();

  factory AppSharedPrefs() {
    return _instance;
  }
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();


  Future<bool> getIsDarkTheme({required bool defaultValue}) async {
    return _preferences.then((SharedPreferences prefs) {
      return prefs.getBool(theme) ?? defaultValue;
    });
  }

  Future<bool> setDarkTheme(bool value) async {
    return _preferences.then((SharedPreferences prefs) {
      prefs.setBool(theme, value);
      return true;
    });
  }

}
