import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/network/token_manager.dart';
import '../model/explore_model.dart';

class ExploreDashboard {
  final List<ExploreLocalShare> localShares;
  final List<ExploreFollowUser> suggestedUsers;
  final List<ExploreFeaturedLocation> featuredLocations;
  final List<ExploreNewLocal> newLocals;
  final List<ExploreFeaturedRoute> featuredRoutes;

  const ExploreDashboard({
    required this.localShares,
    required this.suggestedUsers,
    required this.featuredLocations,
    required this.newLocals,
    required this.featuredRoutes,
  });

  factory ExploreDashboard.fromApi(Map<String, dynamic> json) {
    return ExploreDashboard(
      localShares: (json['local_shares'] as List? ?? [])
          .map((e) => ExploreLocalShare.fromApi(e as Map<String, dynamic>))
          .toList(),
      suggestedUsers: (json['suggested_users'] as List? ?? [])
          .map((e) => ExploreFollowUser.fromApi(e as Map<String, dynamic>))
          .toList(),
      featuredLocations: (json['featured_locations'] as List? ?? [])
          .map(
            (e) => ExploreFeaturedLocation.fromApi(e as Map<String, dynamic>),
          )
          .toList(),
      newLocals: (json['new_locals'] as List? ?? [])
          .map((e) => ExploreNewLocal.fromApi(e as Map<String, dynamic>))
          .toList(),
      featuredRoutes: (json['featured_routes'] as List? ?? [])
          .map((e) => ExploreFeaturedRoute.fromApi(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

abstract class ExploreRepository {
  List<ExploreStory> loadStories();
  void saveStories(List<ExploreStory> stories);
  void addSlideToYourStory(StorySlide slide);
  void deleteYourStory();
  void deleteYourStorySlide(String slideId);

  Future<List<ExploreStory>> fetchStoryFeed();
  Future<StorySlide> uploadStory(File imageFile);
  Future<void> markStoryViewed(String storyId);
  Future<bool> likeStory(String storyId);

  Future<ExploreDashboard> fetchDashboard();
  Future<bool> likeLocalShare(String shareId);
  Future<void> toggleFollow(String userId);
}

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl._();

  static final ExploreRepositoryImpl instance = ExploreRepositoryImpl._();

  final ApiClient _client = ApiClient();

  List<StorySlide> _yourSlides = [];
  List<StoryViewer> _yourViewers = [];

  // ─── Local: Your Story ──────────────────────────────────────────────────────

  @override
  List<ExploreStory> loadStories() {
    _yourSlides = _yourSlides.where((s) => !s.isExpired).toList();
    if (_yourSlides.isEmpty) _yourViewers = [];

    return [
      ExploreStory(
        id: 'you',
        name: 'Your story',
        isYourStory: true,
        slides: List<StorySlide>.from(_yourSlides),
        viewers: List<StoryViewer>.from(_yourViewers),
      ),
    ];
  }

  @override
  void saveStories(List<ExploreStory> stories) {
    final yours = stories.firstWhere(
      (s) => s.isYourStory,
      orElse: () => ExploreModel.yourStoryPlaceholder,
    );
    _yourSlides = yours.slides.where((s) => !s.isExpired).toList();
    _yourViewers = List<StoryViewer>.from(yours.viewers);
  }

  @override
  void addSlideToYourStory(StorySlide slide) {
    _yourSlides = [..._yourSlides.where((s) => !s.isExpired), slide];
    // Viewer data is owned by the backend — a freshly uploaded story starts
    // with zero viewers and the real count arrives with the next feed load.
    // (No fake/seeded viewers.)
  }

  @override
  void deleteYourStory() {
    _yourSlides = [];
    _yourViewers = [];
  }

  @override
  void deleteYourStorySlide(String slideId) {
    _yourSlides = _yourSlides.where((s) => s.id != slideId).toList();
    if (_yourSlides.isEmpty) _yourViewers = [];
  }

  // ─── Remote API: Stories ────────────────────────────────────────────────────

  @override
  Future<List<ExploreStory>> fetchStoryFeed() async {
    final response = await _client.get('/social/stories/feed/?page=1');
    final results = response['results'] as List? ?? [];
    return results
        .map((item) => ExploreStory.fromApi(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<StorySlide> uploadStory(File imageFile) async {
    final token = await TokenManager().accessToken;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiClient.baseUrl}/social/stories/'),
    );

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    print('');
    print('┌─── API REQUEST ───────────────────────────────────');
    print('│ POST /social/stories/ (multipart image upload)');
    print('│ File: ${imageFile.path}');
    print('└────────────────────────────────────────────────────');

    final streamed = await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamed);
    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    print('');
    print(
      '┌─── API RESPONSE ${isSuccess ? "✅" : "❌"} ─────────────────────────────',
    );
    print('│ Status: ${response.statusCode}');
    print('│ Body: ${response.body}');
    print('└────────────────────────────────────────────────────');

    if (!isSuccess) {
      throw const ApiException('Failed to upload story. Please try again.');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return StorySlide.fromApi(json);
  }

  @override
  Future<void> markStoryViewed(String storyId) async {
    await _client.post('/social/stories/$storyId/view/', {});
  }

  @override
  Future<bool> likeStory(String storyId) async {
    final response = await _client.post('/social/stories/$storyId/like/', {});
    return response['liked'] as bool? ?? false;
  }

  // ─── Remote API: Dashboard ──────────────────────────────────────────────────

  @override
  Future<ExploreDashboard> fetchDashboard() async {
    final response = await _client.get('/explore/dashboard/');
    return ExploreDashboard.fromApi(response);
  }

  @override
  Future<bool> likeLocalShare(String shareId) async {
    final response = await _client.post(
      '/explore/local-shares/$shareId/like/',
      {},
    );
    return response['liked'] as bool? ?? false;
  }

  @override
  Future<void> toggleFollow(String userId) async {
    await _client.post('/social/profiles/$userId/follow/', {});
  }
}
