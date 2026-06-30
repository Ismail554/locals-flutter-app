import 'package:locals/core/network/api_client.dart';
import '../../explore/model/explore_model.dart';

abstract class FindLocalsRepository {
  Future<List<ExploreFollowUser>> fetchSuggestions();
  Future<bool> toggleFollow(String userId);
}

class FindLocalsRepositoryImpl implements FindLocalsRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<List<ExploreFollowUser>> fetchSuggestions() async {
    final response = await _client.get('/social/suggestions/');
    final results = response['results'] as List? ?? [];
    return results
        .map((item) => ExploreFollowUser.fromApi(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> toggleFollow(String userId) async {
    final response = await _client.post('/social/profiles/$userId/follow/', {});
    final detail = response['detail'] as String? ?? '';
    // API returns a message rather than a boolean — infer state from text
    return detail.toLowerCase().contains('followed successfully') &&
        !detail.toLowerCase().contains('unfollowed');
  }
}