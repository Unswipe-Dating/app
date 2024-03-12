import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(6, 28, 51, 1);
  static const Color secondary = Color.fromRGBO(20, 157, 212, 1);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
}

enum InfoIcon { height, sunSign, workLocation, homeLocation }

extension CustomInfoIcon on InfoIcon {
  String get icon {
    switch (this) {
      case InfoIcon.height:
        return "assets/images/height_icon.svg";
      case InfoIcon.sunSign:
        return "assets/images/zodiac_icon.svg";
      case InfoIcon.workLocation:
        return "assets/images/location_icon.svg";
      case InfoIcon.homeLocation:
        return "assets/images/home_icon.svg";

    }
  }
}