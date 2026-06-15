import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../events_progress_map/model/events_progress_map_args.dart';
import '../model/join_event_args.dart';
import '../model/join_event_model.dart';
import '../repository/join_event_repository.dart';
import '../../restaurant_view_details/model/restaurant_view_details_args.dart';

class JoinEventController extends ChangeNotifier {
  final JoinEventRepository repo;
  final JoinEventArgs args;
  JoinEventModel event;

  JoinEventController(this.repo, this.args) : event = repo.load(args.eventId);

  void joinEvent(BuildContext context) {
    if (event.isJoined) return;

    event = event.copyWith(isJoined: true);
    notifyListeners();

    context.push(
      '/events_progress_map',
      extra: EventsProgressMapArgs(eventId: event.id),
    );
  }

  void openStop(BuildContext context, JoinEventRouteStop stop) {
    final locationId = stop.locationId;
    if (locationId == null) return;

    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: locationId),
    );
  }
}
