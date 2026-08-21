import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/missions_model.dart';
import '../repository/missions_repository.dart';

class MissionsController extends ChangeNotifier {
  final MissionsRepository repo;
  MissionsModel state = const MissionsModel();

  bool isLoading = false;
  String? errorMessage;

  // TODO: replace with real device location (e.g. via geolocator).
  static const double _defaultLat = 23.777176;
  static const double _defaultLng = 90.399452;

  MissionsController(this.repo) {
    _fetch();
  }

  Future<void> _fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      final missions = await repo.fetchMissions(
        filter: state.selectedFilter,
        lat: _defaultLat,
        lng: _defaultLng,
      );
      state = state.copyWith(missions: missions);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => _fetch();

  Future<void> selectFilter(MissionFilter filter) async {
    state = state.copyWith(selectedFilter: filter);
    notifyListeners();
    await _fetch();
  }

  void openMissionDetails(BuildContext context, String missionId) {
    context.push('/mission_details', extra: missionId);
  }

  void openAchievements(BuildContext context) {
    context.push('/achievements');
  }
}
