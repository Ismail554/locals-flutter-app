import 'package:locals/core/network/api_client.dart';
import '../model/join_event_model.dart';

abstract class JoinEventRepository {
  Future<JoinEventModel> load(String eventId);
}

class JoinEventRepositoryImpl implements JoinEventRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<JoinEventModel> load(String eventId) async {
    final response =
        await _client.get('/gamification/missions/$eventId/');
    return JoinEventModel.fromApi(response);
  }
}