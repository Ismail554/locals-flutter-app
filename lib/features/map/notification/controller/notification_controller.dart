import '../model/notification_model.dart';
import '../repository/notification_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationController extends ChangeNotifier {
  final NotificationRepository repo;
  NotificationModel state = const NotificationModel();

  NotificationController(this.repo) {
    markAllRead();
  }

  void markAllRead() {
    state = state.copyWith(
      items: state.items.map((item) => item.copyWith(isRead: true)).toList(),
    );
    notifyListeners();
  }

  void markRead(String id) {
    state = state.copyWith(
      items: state.items
          .map((item) => item.id == id ? item.copyWith(isRead: true) : item)
          .toList(),
    );
    notifyListeners();
  }
}
