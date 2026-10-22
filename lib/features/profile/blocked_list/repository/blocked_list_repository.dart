import 'package:locals/core/network/api_client.dart';
import '../model/blocked_list_model.dart';

abstract class BlockedListRepository {
  Future<List<BlockedUser>> fetchBlocked();
  Future<void> unblock(String userId);
}

class BlockedListRepositoryImpl implements BlockedListRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<List<BlockedUser>> fetchBlocked() async {
    final response = await _client.get('/social/blocked/');
    final results = response['results'] as List? ?? [];
    return results
        .map((item) => BlockedUser.fromApi(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> unblock(String userId) async {
    // ⚠️ No unblock endpoint was provided in the API docs.
    // Guessing the symmetric path based on the follow/block pattern seen
    // elsewhere (e.g. POST /social/profiles/:id/follow/). Please confirm
    // the real endpoint and swap this in — likely one of:
    //   POST /social/profiles/$userId/block/   (toggle, same as follow)
    //   POST /social/profiles/$userId/unblock/
    await _client.post('/social/profiles/$userId/block/', {});
  }
}