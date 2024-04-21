import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(6, 28, 51, 1);
  static const Color secondary = Color.fromRGBO(20, 157, 212, 1);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const primaryColor = Color(0xFF1A1A1A);
  static const orange = Color(0xFFFF5433);
  static const lightGray = Color(0xFFdddddd);
  static const darkGray = Color(0xFF808080);
  static const gray = Color(0xFF9A9A9A);
  static const red = Color(0xFFD32F2F);
  static const transparent = Colors.transparent;
}

void showConfirmationDialog(
  BuildContext context,
  String message, {
  required VoidCallback onAccept,
  required VoidCallback onReject,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirmation"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onAccept();
            },
            child: const Text("Accept"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onReject();
            },
            child: const Text("Reject"),
          ),
        ],
      );
    },
  );
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
