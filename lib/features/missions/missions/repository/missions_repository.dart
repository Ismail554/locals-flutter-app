import 'package:locals/core/network/api_client.dart';
import '../model/missions_model.dart';

abstract class MissionsRepository {
  Future<List<MissionItem>> fetchMissions({
    required MissionFilter filter,
    required double lat,
    required double lng,
  });
}

class MissionsRepositoryImpl implements MissionsRepository {
  final ApiClient _client = ApiClient();

  static const Map<MissionFilter, String> _tabParams = {
    MissionFilter.nearby: 'nearby',
    MissionFilter.active: 'active',
    MissionFilter.completed: 'completed',
    MissionFilter.events: 'events',
  };

  @override
  Future<List<MissionItem>> fetchMissions({
    required MissionFilter filter,
    required double lat,
    required double lng,
  }) async {
    final tab = _tabParams[filter]!;
    final response = await _client.get(
      '/gamification/missions/?tab=$tab&lat=$lat&lng=$lng',
    );

    final List<dynamic> rawMissions =
        (response['results'] as List<dynamic>?) ?? [];

    return rawMissions.map((raw) {
      final map = raw as Map<String, dynamic>;

      final totalStops = _asInt(map['total_stops'], fallback: 1);
      final progressParts =
          (map['user_progress'] as String? ?? '0/$totalStops').split('/');
      final currentProgress = int.tryParse(progressParts[0]) ?? 0;
      final totalProgress = progressParts.length > 1
          ? int.tryParse(progressParts[1]) ?? totalStops
          : totalStops;

      return MissionItem(
        id: map['id'].toString(),
        title: map['title'] as String? ?? '',
        description: map['description'] as String? ?? '',
        points: _asInt(map['reward_points']),
        difficulty: (map['difficulty'] as String? ?? '').toUpperCase(),
        distance: _formatDistanceKm(map['distance_km']),
        currentProgress: currentProgress,
        totalProgress: totalProgress,
      );
    }).toList();
  }

  int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  String _formatDistanceKm(dynamic distanceKm) {
    if (distanceKm == null) return '';
    final km = distanceKm is num
        ? distanceKm.toDouble()
        : double.tryParse(distanceKm.toString()) ?? 0;
    return '${km.toStringAsFixed(1)} Km';
  }
}