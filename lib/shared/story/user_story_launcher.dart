import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/explore/model/explore_model.dart';
import 'package:locals/features/explore/explore/repository/explore_repository.dart';
import 'package:locals/features/explore/story_view/model/story_view_args.dart';

class UserStoryLauncher {
  UserStoryLauncher._();

  static List<ExploreStory> _stories() =>
      ExploreRepositoryImpl.instance.loadStories();

  static ExploreStory? storyFor(String? userId) {
    if (userId == null) return null;
    final index = _stories().indexWhere((story) => story.id == userId);
    if (index < 0) return null;
    return _stories()[index];
  }

  static bool hasStory(String? userId) => storyFor(userId)?.hasStory ?? false;

  static bool isViewed(String? userId) => storyFor(userId)?.isViewed ?? false;

  static Future<void>? open(BuildContext context, String userId) {
    if (!hasStory(userId)) return null;

    final stories = _stories();
    final storiesWithContent =
        stories.where((story) => story.hasStory).toList();
    final viewerIndex =
        storiesWithContent.indexWhere((story) => story.id == userId);
    if (viewerIndex < 0) return null;

    return context.push(
      '/story_view',
      extra: StoryViewerArgs(
        stories: List<ExploreStory>.from(stories),
        initialStoryIndex: viewerIndex,
        onStoriesUpdated: ExploreRepositoryImpl.instance.saveStories,
      ),
    );
  }
}
