import 'package:flutter/foundation.dart';
import '../model/privacy_model.dart';
import '../repository/privacy_repository.dart';

class PrivacyController extends ChangeNotifier {
  final PrivacyRepository repo;
  PrivacyModel state = const PrivacyModel();

  bool isLoading = false;
  bool isSaving = false;
  String? errorMessage;

  String _language = 'en';
  bool _notifyMissions = true;
  bool _notifyEvents = true;

  PrivacyController(this.repo) {
    load();
  }

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final settings = await repo.loadSettings();
      _applyApiSettings(settings);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfileVisibility(String optionId) async {
    final option = state.profileVisibility.options.firstWhere(
      (o) => o.id == optionId,
    );
    final previousState = state;
    state = state.copyWith(
      profileVisibility: state.profileVisibility.copyWith(value: option.value),
    );
    notifyListeners();
    await _save(previousState);
  }

  Future<void> updatePhotoVisibility(String optionId) async {
    final option = state.photoVisibility.options.firstWhere(
      (o) => o.id == optionId,
    );
    final previousState = state;
    state = state.copyWith(
      photoVisibility: state.photoVisibility.copyWith(value: option.value),
    );
    notifyListeners();
    await _save(previousState);
  }

  void updateLocationPermission(String optionId) {
    final option = state.locationPermission.options.firstWhere(
      (o) => o.id == optionId,
    );
    state = state.copyWith(
      locationPermission: state.locationPermission.copyWith(
        value: option.value,
      ),
    );
    notifyListeners();
  }

  Future<void> updateLeaderboardVisibility(String optionId) async {
    final option = state.leaderboardVisibility.options.firstWhere(
      (o) => o.id == optionId,
    );
    final previousState = state;
    state = state.copyWith(
      leaderboardVisibility: state.leaderboardVisibility.copyWith(
        value: option.value,
      ),
    );
    notifyListeners();
    await _save(previousState);
  }

  String selectedId<T>(PrivacySetting<T> setting) {
    return setting.options.firstWhere((o) => o.value == setting.value).id;
  }

  void _applyApiSettings(Map<String, dynamic> settings) {
    _language = settings['language'] as String? ?? _language;
    _notifyMissions = settings['notify_missions'] as bool? ?? _notifyMissions;
    _notifyEvents = settings['notify_events'] as bool? ?? _notifyEvents;

    final profileVisibility = _profileVisibilityFromApi(
      settings['profile_visibility'],
    );
    final photoVisibility = _photoVisibilityFromApi(
      settings['photo_visibility'],
    );
    final leaderboardVisibility = settings['show_on_leaderboard'] as bool?;

    state = state.copyWith(
      profileVisibility: state.profileVisibility.copyWith(
        value: profileVisibility,
      ),
      photoVisibility: state.photoVisibility.copyWith(value: photoVisibility),
      leaderboardVisibility: leaderboardVisibility == null
          ? null
          : state.leaderboardVisibility.copyWith(
              value: leaderboardVisibility
                  ? LeaderboardVisibility.on
                  : LeaderboardVisibility.off,
            ),
    );
  }

  Future<void> _save(PrivacyModel previousState) async {
    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await repo.updateSettings(_settingsPayload());
      _applyApiSettings(response);
    } catch (e) {
      state = previousState;
      errorMessage = e.toString();
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Map<String, dynamic> _settingsPayload() {
    return {
      'language': _language,
      'notify_missions': _notifyMissions,
      'notify_events': _notifyEvents,
      'profile_visibility': _profileVisibilityToApi(
        state.profileVisibility.value,
      ),
      'photo_visibility': _photoVisibilityToApi(state.photoVisibility.value),
      'show_on_leaderboard':
          state.leaderboardVisibility.value == LeaderboardVisibility.on,
    };
  }

  ProfileVisibility _profileVisibilityFromApi(Object? value) {
    return value.toString().toUpperCase() == 'PRIVATE'
        ? ProfileVisibility.private
        : ProfileVisibility.public;
  }

  PhotoVisibility _photoVisibilityFromApi(Object? value) {
    return value.toString().toUpperCase() == 'PUBLIC'
        ? PhotoVisibility.public
        : PhotoVisibility.followersOnly;
  }

  String _profileVisibilityToApi(ProfileVisibility value) {
    return value == ProfileVisibility.private ? 'PRIVATE' : 'PUBLIC';
  }

  String _photoVisibilityToApi(PhotoVisibility value) {
    return value == PhotoVisibility.public ? 'PUBLIC' : 'FOLLOWERS_ONLY';
  }
}
