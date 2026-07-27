import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/app/router.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.initializeBackground();
  await NotificationService.instance.showRemoteNotification(message);
}

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _requestPermission();
    await initializeBackground();
    await _setupForegroundNotification();
    await _listenNotificationTap();
    await _printToken();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> initializeBackground() async {
    await _initializeLocalNotification();
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _initializeLocalNotification() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) async {
        _handleNotificationTap(response.payload);
      },
    );

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(channel);
  }

  Future<void> _setupForegroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showRemoteNotification(message);
    });
  }

  Future<void> showRemoteNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _listenNotificationTap() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(jsonEncode(message.data));
    });

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(jsonEncode(initialMessage.data));
    }
  }

  Future<void> _printToken() async {
    final token = await _messaging.getToken();
    debugPrint('FCM TOKEN => $token');

    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('TOKEN REFRESH => $newToken');
    });
  }

  void _handleNotificationTap(String? payload) {
    if (payload == null || payload.isEmpty) {
      appRouter.go('/notification');
      return;
    }

    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final route = data['route'] as String? ?? '/notification';
      appRouter.go(route);
    } catch (_) {
      appRouter.go('/notification');
    }
  }
}
