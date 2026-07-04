import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';
import '../model/mission_details_model.dart';
import '../repository/mission_details_repository.dart';

class MissionDetailsController extends ChangeNotifier {
  final MissionDetailsRepository repo;
  final String? missionId;

  MissionDetailsModel state = MissionDetailsModel.empty();
  bool isLoading = false;
  bool isStarting = false;
  String? errorMessage;

  MissionDetailsController(this.repo, {this.missionId}) {
    if (missionId != null) {
      _fetch(missionId!);
    }
  }

  Future<void> _fetch(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      state = await repo.fetchMissionDetails(id);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> continueMission(BuildContext context) async {
    if (missionId == null || isStarting) return;

    isStarting = true;
    notifyListeners();

    try {
      await repo.startMission(missionId!);
    } catch (e) {
      isStarting = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not start mission: $e')),
        );
      }
      return;
    }

    isStarting = false;
    notifyListeners();

    final nextStop = state.stops.firstWhere(
      (s) => s.status == MissionStopStatus.pending,
      orElse: () => state.stops.isNotEmpty
          ? state.stops.first
          : const MissionStop(
              number: 0,
              name: '',
              category: '',
              address: '',
              status: MissionStopStatus.pending,
            ),
    );

    if (!context.mounted) return;

    context.go(
      '/map',
      extra: MapMissionArgs(
        city: 'Barcelona',
        completedCount: state.progressCurrent,
        totalCount: state.progressTotal,
        activeLocation: MapActiveLocation(
          locationId: state.id,
          category: nextStop.category,
          seal: 'Seal',
          name: nextStop.name,
          address: nextStop.address,
          points: state.reward,
          imageColor: const Color(0xFFD4C4B0),
          latitude: nextStop.latitude ?? 41.3833,
          longitude: nextStop.longitude ?? 2.1833,
        ),
      ),
    );
  }
}