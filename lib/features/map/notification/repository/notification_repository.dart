import 'package:locals/core/network/api_client.dart';

import '../model/notification_model.dart';

abstract class NotificationRepository {
  /// Get notifications
  Future<NotificationModel> getNotifications({int page = 1});

  /// Mark a notification as read
  Future<void> markAsRead(String id);

  /// Register current device FCM token
  Future<void> registerDevice({
    required String registrationId,
    required String deviceType,
  });
}

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<NotificationModel> getNotifications({int page = 1}) async {
    final response = await _client.get(
      '/notifications/?page=$page',
    );

    return NotificationModel.fromJson(response);
  }

  @override
  Future<void> markAsRead(String id) async {
    await _client.post(
      '/notifications/$id/read/',
      {},
    );
  }

  @override
  Future<void> registerDevice({
    required String registrationId,
    required String deviceType,
  }) async {
    await _client.post(
      '/notifications/devices/',
      {
        "registration_id": registrationId,
        "device_type": deviceType,
      },
    );
  }
}