import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/events_routes_model.dart';
import '../repository/events_routes_repository.dart';
import '../../join_event/model/join_event_args.dart';

class EventsRoutesController extends ChangeNotifier {
  final EventsRoutesRepository repo;
  EventsRoutesModel state = const EventsRoutesModel(isLoading: true);

  EventsRoutesController(this.repo) {
    _load();
  }

  Future<void> _load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      state = await repo.load();
    } catch (e) {
      print('Events routes load error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load events. Please try again.',
      );
    }

    notifyListeners();
  }

  Future<void> refresh() => _load();

  void openEvent(BuildContext context, String eventId) {
    context.push('/join_event', extra: JoinEventArgs(eventId: eventId));
  }
}