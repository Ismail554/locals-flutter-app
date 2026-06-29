import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/network/token_manager.dart';
import '../model/explore_model.dart';

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
    if (_yourViewers.isEmpty) _yourViewers = _seedViewers();
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

  // ─── Remote API ─────────────────────────────────────────────────────────────

  @override
  Future<List<ExploreStory>> fetchStoryFeed() async {
    // ApiClient prepends baseUrl + /api/v1 — so path starts after that
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

  // ─── Helpers ────────────────────────────────────────────────────────────────

  static List<StoryViewer> _seedViewers() {
    final now = DateTime.now();
    return [
      StoryViewer(
        id: 'marta',
        name: 'Marta Roig',
        viewedAt: now.subtract(const Duration(minutes: 8)),
        avatarColor: const Color(0xFFD4A574),
      ),
      StoryViewer(
        id: 'aina',
        name: 'Aina V.',
        viewedAt: now.subtract(const Duration(minutes: 22)),
        avatarColor: const Color(0xFFE8A0A0),
      ),
    ];
  }
  
  @override
  Future<bool> likeStory(String storyId) async{
    final response = await _client.post(
    '/social/stories/$storyId/like/',
    {},
  );

  return response['liked'] as bool? ?? false;
  }
}
