import 'package:flutter/material.dart';
import '../model/explore_model.dart';

abstract class ExploreRepository {
  List<ExploreStory> loadStories();
  void saveStories(List<ExploreStory> stories);
  void addSlideToYourStory(StorySlide slide);
  void deleteYourStory();
  void deleteYourStorySlide(String slideId);
}

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl._();

  static final ExploreRepositoryImpl instance = ExploreRepositoryImpl._();

  List<ExploreStory> _stories =
      List<ExploreStory>.from(ExploreModel.defaultStories);

  static List<StoryViewer> _seedYourStoryViewers() {
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
      StoryViewer(
        id: 'joan',
        name: 'Joan P.',
        viewedAt: now.subtract(const Duration(hours: 1)),
        avatarColor: const Color(0xFF7EB8DA),
      ),
    ];
  }

  List<ExploreStory> _pruneExpired(List<ExploreStory> stories) {
    return stories.map((story) {
      final active = story.slides.where((slide) => !slide.isExpired).toList();
      if (active.length == story.slides.length) return story;
      return story.copyWith(slides: active);
    }).toList();
  }

  @override
  List<ExploreStory> loadStories() {
    _stories = _pruneExpired(_stories);
    return List<ExploreStory>.from(_stories);
  }

  @override
  void saveStories(List<ExploreStory> stories) {
    _stories = _pruneExpired(List<ExploreStory>.from(stories));
  }

  @override
  void addSlideToYourStory(StorySlide slide) {
    _stories = _stories.map((story) {
      if (!story.isYourStory) return story;

      final activeSlides = [
        ...story.slides.where((s) => !s.isExpired),
        slide,
      ];
      final viewers = story.viewers.isEmpty
          ? _seedYourStoryViewers()
          : story.viewers;

      return story.copyWith(slides: activeSlides, viewers: viewers);
    }).toList();
  }

  @override
  void deleteYourStory() {
    _stories = _stories.map((story) {
      if (!story.isYourStory) return story;
      return story.copyWith(slides: [], viewers: []);
    }).toList();
  }

  @override
  void deleteYourStorySlide(String slideId) {
    _stories = _stories.map((story) {
      if (!story.isYourStory) return story;

      final slides =
          story.slides.where((slide) => slide.id != slideId).toList();
      final viewers = slides.isEmpty ? <StoryViewer>[] : story.viewers;

      return story.copyWith(slides: slides, viewers: viewers);
    }).toList();
  }
}
