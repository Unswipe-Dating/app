


import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async{
    return await messaging.getToken();
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized) {

      debugPrint("");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint("");

    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }

  }
}