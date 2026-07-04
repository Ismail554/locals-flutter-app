import 'package:locals/core/network/api_client.dart';
import '../model/events_routes_model.dart';

abstract class EventsRoutesRepository {
  Future<EventsRoutesModel> load();
}

class EventsRoutesRepositoryImpl implements EventsRoutesRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<EventsRoutesModel> load() async {
    final response =
        await _client.get('/gamification/missions/?tab=events');
    final results = response['results'] as List? ?? [];
    final events = results
        .map((item) =>
            EventRouteItem.fromApi(item as Map<String, dynamic>))
        .toList();
    return EventsRoutesModel(events: events);
  }
}