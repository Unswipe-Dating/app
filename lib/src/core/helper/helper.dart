import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../shared/data/data_sources/app_shared_prefs.dart';
import '../../shared/utils/language_enum.dart';
import '../utils/constant/app_constants.dart';


class Helper {

  static LanguageEnum getLang() {
    LanguageEnum? lang;
   // lang = GetIt.I.get<AppSharedPrefs>().getLang();
    lang = lang ?? LanguageEnum.en;
    return lang;
  }

  /// Get svg picture path
  static String getSvgPath(String name) {
    return "$svgPath$name";
  }

  /// Get image picture path
  static String getImagePath(String name) {
    return "$imagePath$name";
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {}..removeWhere((key, value) => value == null);
  }

  static bool isDarkTheme() {
    return false;
    // return GetIt.I.getAsync<AppSharedPrefs>().getIsDarkTheme();
  }
}
