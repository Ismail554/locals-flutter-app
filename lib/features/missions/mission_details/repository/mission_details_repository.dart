import 'package:locals/core/network/api_client.dart';
import '../model/mission_details_model.dart';

abstract class MissionDetailsRepository {
  Future<MissionDetailsModel> fetchMissionDetails(String missionId);
  Future<void> startMission(String missionId);
}

class MissionDetailsRepositoryImpl implements MissionDetailsRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<MissionDetailsModel> fetchMissionDetails(String missionId) async {
    final response = await _client.get('/gamification/missions/$missionId/');

    final List<dynamic> rawStops = (response['stops'] as List<dynamic>?) ?? [];

    final stops = rawStops.map((raw) {
      final map = raw as Map<String, dynamic>;
      final place = map['place'] as Map<String, dynamic>? ?? {};
      final category = place['category'] as Map<String, dynamic>?;
      final isCompleted = map['is_completed'] as bool? ?? false;

      return MissionStop(
        placeId: place['id'].toString(),
        number: _asInt(map['order']),
        name: place['name'] ?? '',
        category: category?['name'] ?? '',
        address: place['address'] ?? '',
        city: place['city']?['name'] ?? '',
        seal: place['seal']?['name'] ?? '',
        status: isCompleted
            ? MissionStopStatus.completed
            : MissionStopStatus.pending,
        latitude: double.tryParse(place['latitude']?.toString() ?? ''),
        longitude: double.tryParse(place['longitude']?.toString() ?? ''),
      );
    }).toList()..sort((a, b) => a.number.compareTo(b.number));

    final totalStops = stops.length;
    final progressCurrent = stops
        .where((s) => s.status == MissionStopStatus.completed)
        .length;

    return MissionDetailsModel(
      id: response['id'].toString(),
      title: response['title'] as String? ?? '',
      description: response['description'] as String? ?? '',
      reward: _asInt(response['reward_points']),
      totalStops: totalStops,
      level: (response['difficulty'] as String? ?? '').toUpperCase(),
      progressCurrent: progressCurrent,
      progressTotal: totalStops,
      stops: stops,  
    );
  }

  @override
  Future<void> startMission(String missionId) async {
    await _client.post('/gamification/missions/$missionId/start/', {});
  }

  int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }
}
