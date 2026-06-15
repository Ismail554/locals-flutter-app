import '../model/join_event_model.dart';

abstract class JoinEventRepository {
  JoinEventModel load(String eventId);
}

class JoinEventRepositoryImpl implements JoinEventRepository {
  @override
  JoinEventModel load(String eventId) => JoinEventModel.byId(eventId);
}
