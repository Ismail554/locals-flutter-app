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
    if (missionId != null) _fetch(missionId!);
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

  Future<void> refresh() async {
    final id = missionId;
    if (id != null) await _fetch(id);
  }

  void openStop(BuildContext context, MissionStop stop) {
    if (stop.latitude == null || stop.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location coordinates not available')),
      );
      return;
    }

    context.go(
      '/map',
      extra: MapMissionArgs(
        city: stop.city,
        completedCount: state.progressCurrent,
        totalCount: state.progressTotal,
        activeLocation: MapActiveLocation(
          locationId: stop.placeId,
          category: stop.category,
          seal: stop.seal,
          name: stop.name,
          address: stop.address,
          points: state.reward,
          imageColor: const Color(0xFFD4C4B0),
          latitude: stop.latitude!,
          longitude: stop.longitude!,
        ),
      ),
    );
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not start mission: $e')));
      }
      return;
    }

    isStarting = false;
    notifyListeners();

    // Get next pending stop
    final nextStop = state.stops.firstWhere(
      (s) => s.status == MissionStopStatus.pending,
      orElse: () =>
          state.stops.firstOrNull ??
          const MissionStop(
            number: 0,
            name: '',
            category: '',
            address: '',
            status: MissionStopStatus.pending,
            placeId: '',
            city: '',
            seal: '',
          ),
    );

    if (!context.mounted ||
        nextStop.latitude == null ||
        nextStop.longitude == null) {
      return;
    }

    context.go(
      '/map',
      extra: MapMissionArgs(
        city: nextStop.city.isNotEmpty ? nextStop.city : 'Barcelona',
        completedCount: state.progressCurrent,
        totalCount: state.progressTotal,
        activeLocation: MapActiveLocation(
          locationId: nextStop.placeId,
          category: nextStop.category,
          seal: nextStop.seal,
          name: nextStop.name,
          address: nextStop.address,
          points: state.reward,
          imageColor: const Color(0xFFD4C4B0),
          latitude: nextStop.latitude!,
          longitude: nextStop.longitude!,
        ),
      ),
    );
  }
}
