import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/events_routes_model.dart';
import '../repository/events_routes_repository.dart';
import '../../join_event/model/join_event_args.dart';

class EventsRoutesController extends ChangeNotifier {
  final EventsRoutesRepository repo;
  EventsRoutesModel state;

  EventsRoutesController(this.repo) : state = repo.load();

  void openEvent(BuildContext context, String eventId) {
    context.push(
      '/join_event',
      extra: JoinEventArgs(eventId: eventId),
    );
  }
}
