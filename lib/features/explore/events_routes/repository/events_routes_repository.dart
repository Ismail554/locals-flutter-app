import '../model/events_routes_model.dart';

abstract class EventsRoutesRepository {
  EventsRoutesModel load();
}

class EventsRoutesRepositoryImpl implements EventsRoutesRepository {
  @override
  EventsRoutesModel load() => const EventsRoutesModel();
}
