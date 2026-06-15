import '../model/events_progress_map_model.dart';

abstract class EventsProgressMapRepository {
  EventsProgressMapModel load(String eventId, {int? completedStops});
}

class EventsProgressMapRepositoryImpl implements EventsProgressMapRepository {
  @override
  EventsProgressMapModel load(String eventId, {int? completedStops}) {
    final model = EventsProgressMapModel.byEventId(eventId);
    if (completedStops == null || completedStops == model.completedStops) {
      return model;
    }
    return model.withCompletedStops(completedStops);
  }
}
