import 'package:flutter/foundation.dart';
import '../model/set_notification_model.dart';
import '../repository/set_notification_repository.dart';

class SetNotificationController extends ChangeNotifier {
  final SetNotificationRepository repo;
  SetNotificationModel state = const SetNotificationModel();

  SetNotificationController(this.repo);

  void toggleSetting(String id, bool value) {
    state = state.copyWith(
      settings: state.settings
          .map((s) => s.id == id ? s.copyWith(enabled: value) : s)
          .toList(),
    );
    notifyListeners();
  }
}
