import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/missions_model.dart';
import '../repository/missions_repository.dart';

class MissionsController extends ChangeNotifier {
  final MissionsRepository repo;
  MissionsModel state = const MissionsModel();

  MissionsController(this.repo);

  void selectFilter(MissionFilter filter) {
    state = state.copyWith(selectedFilter: filter);
    notifyListeners();
  }

  void openMissionDetails(BuildContext context, String missionId) {
    context.push('/mission_details', extra: missionId);
  }

  void openAchievements(BuildContext context) {
    context.push('/achievements');
  }
}
