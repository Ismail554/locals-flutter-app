import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/events_progress_map_args.dart';
import '../model/events_progress_map_model.dart';
import '../repository/events_progress_map_repository.dart';
import '../../points/model/points_args.dart';

class EventsProgressMapController extends ChangeNotifier {
  final EventsProgressMapRepository repo;
  final EventsProgressMapArgs args;
  EventsProgressMapModel state;

  EventsProgressMapController(this.repo, this.args)
      : state = repo.load(args.eventId, completedStops: args.completedStops);

  Future<void> checkInNextStop(BuildContext context) async {
    final nextStop = state.nextStop;
    if (nextStop == null) return;

    await context.push(
      '/points',
      extra: PointsArgs(
        locationName: nextStop.name,
        points: nextStop.points,
        cityName: 'Barcelona',
        cityProgress: (state.completedStops + 1) / state.totalStops,
        completedCount: state.completedStops + 1,
        totalCount: state.totalStops,
        locationColor: nextStop.thumbnailColor,
        eventId: state.eventId,
      ),
    );
  }
}
