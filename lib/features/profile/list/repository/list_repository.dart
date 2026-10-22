import 'package:locals/core/network/api_client.dart';
import '../model/list_model.dart';

abstract class ListRepository {
  Future<List<ListUser>> fetchFollowers();
  Future<List<ListUser>> fetchFollowing();
  Future<void> toggleFollow(String userId);
}

class ListRepositoryImpl implements ListRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<List<ListUser>> fetchFollowers() async {
    final response = await _client.get('/social/followers/');
    final results = response['results'] as List? ?? [];
    return results
        .map((item) => ListUser.fromApi(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ListUser>> fetchFollowing() async {
    final response = await _client.get('/social/following/');
    final results = response['results'] as List? ?? [];
    return results
        .map((item) => ListUser.fromApi(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> toggleFollow(String userId) async {
    await _client.post('/social/profiles/$userId/follow/', {});
  }
}