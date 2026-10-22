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

  JoinEventModel? event;
  bool isLoading = true;
  String? errorMessage;

  JoinEventController(this.repo, this.args) {
    _load();
  }

  Future<void> _load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      event = await repo.load(args.eventId);
    } catch (e) {
      print('Join event load error: $e');
      errorMessage = 'Failed to load event. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() => _load();

  void joinEvent(BuildContext context) {
    if (event == null || event!.isJoined) return;

    event = event!.copyWith(isJoined: true);
    notifyListeners();

    context.push(
      '/events_progress_map',
      extra: EventsProgressMapArgs(eventId: event!.id),
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