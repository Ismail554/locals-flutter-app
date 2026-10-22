import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:locals/features/map/notification/repository/notification_repository.dart';

class FCMService {
  FCMService._();

  static Future<void> registerDeviceToken() async {
    try {
      final messaging = FirebaseMessaging.instance;

      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      final token = await messaging.getToken();
      if (token != null && token.isNotEmpty) {
        await NotificationRepositoryImpl().registerDevice(
          registrationId: token,
          deviceType: _deviceType(),
        );
      }

      messaging.onTokenRefresh.listen((newToken) async {
        await NotificationRepositoryImpl().registerDevice(
          registrationId: newToken,
          deviceType: _deviceType(),
        );
      });
    } catch (e) {
      debugPrint('FCM Register Error: $e');
    }
  }

  static String _deviceType() {
    if (kIsWeb) return 'web';
    return defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
  }
}