import 'package:flutter/foundation.dart';
import '../model/privacy_model.dart';
import '../repository/privacy_repository.dart';

class PrivacyController extends ChangeNotifier {
  final PrivacyRepository repo;
  PrivacyModel state = const PrivacyModel();

  PrivacyController(this.repo);

  void updateProfileVisibility(String optionId) {
    final option = state.profileVisibility.options
        .firstWhere((o) => o.id == optionId);
    state = state.copyWith(
      profileVisibility: state.profileVisibility.copyWith(value: option.value),
    );
    notifyListeners();
  }

  void updatePhotoVisibility(String optionId) {
    final option =
        state.photoVisibility.options.firstWhere((o) => o.id == optionId);
    state = state.copyWith(
      photoVisibility: state.photoVisibility.copyWith(value: option.value),
    );
    notifyListeners();
  }

  void updateLocationPermission(String optionId) {
    final option =
        state.locationPermission.options.firstWhere((o) => o.id == optionId);
    state = state.copyWith(
      locationPermission: state.locationPermission.copyWith(value: option.value),
    );
    notifyListeners();
  }

  void updateLeaderboardVisibility(String optionId) {
    final option = state.leaderboardVisibility.options
        .firstWhere((o) => o.id == optionId);
    state = state.copyWith(
      leaderboardVisibility:
          state.leaderboardVisibility.copyWith(value: option.value),
    );
    notifyListeners();
  }

  String selectedId<T>(PrivacySetting<T> setting) {
    return setting.options
        .firstWhere((o) => o.value == setting.value)
        .id;
  }
}
