import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getDeviceToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // permission request (iOS/Android 13+)
  await messaging.requestPermission();

  String? token = await messaging.getToken();

  print("FCM TOKEN: $token");

  return token;
}