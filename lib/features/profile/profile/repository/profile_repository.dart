import 'package:locals/core/network/api_client.dart';

abstract class ProfileRepository {
  Future<Map<String, dynamic>> fetchProfile(int userId);
  Future<List<dynamic>> fetchAchievements(int userId);
  Future<List<dynamic>> fetchCheckins(int userId);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<Map<String, dynamic>> fetchProfile(int userId) async {
    final response = await _client.get('/social/profiles/$userId/');
    return response as Map<String, dynamic>;
  }

  @override
  Future<List<dynamic>> fetchAchievements(int userId) async {
    final response =
        await _client.get('/gamification/users/$userId/achievements/');
    return (response['data'] as List<dynamic>?) ?? [];
  }

  @override
  Future<List<dynamic>> fetchCheckins(int userId) async {
    final response = await _client.get('/social/users/$userId/checkins/?page=1');
    final map = response as Map<String, dynamic>;
    return (map['results'] as List<dynamic>?) ?? [];
  }
}