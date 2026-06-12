import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../explore/model/explore_model.dart';
import '../../story_view/model/story_view_args.dart';
import '../model/find_locals_args.dart';
import '../model/find_locals_model.dart';
import '../repository/find_locals_repository.dart';

class FindLocalsController extends ChangeNotifier {
  final FindLocalsRepository repo;
  final FindLocalsArgs args;
  FindLocalsModel state;

  FindLocalsController(this.repo, this.args)
      : state = FindLocalsModel(
          users: repo.buildUsers(args.followLocals),
          stories: List<ExploreStory>.from(args.stories),
        );

  void toggleFollow(String id) {
    state = state.copyWith(
      users: state.users
          .map(
            (user) => user.id == id
                ? user.copyWith(isFollowing: !user.isFollowing)
                : user,
          )
          .toList(),
    );
    notifyListeners();
    _syncFollowLocals();
  }

  void _syncFollowLocals() {
    final byId = {for (final user in state.users) user.id: user};
    args.onFollowLocalsUpdated(
      args.followLocals
          .map((user) => byId[user.id] ?? user)
          .toList(),
    );
  }

  void openProfile(BuildContext context) {
    context.push('/view_profile');
  }

  bool hasStory(String userId) {
    final index = state.stories.indexWhere((story) => story.id == userId);
    if (index < 0) return false;
    return state.stories[index].hasStory;
  }

  ExploreStory? storyForUser(String userId) {
    final index = state.stories.indexWhere((story) => story.id == userId);
    if (index < 0) return null;
    final story = state.stories[index];
    return story.hasStory ? story : null;
  }

  void openUserStory(BuildContext context, String userId) {
    if (!hasStory(userId)) return;

    final storiesWithContent =
        state.stories.where((story) => story.hasStory).toList();
    final viewerIndex =
        storiesWithContent.indexWhere((story) => story.id == userId);
    if (viewerIndex < 0) return;

    context.push(
      '/story_view',
      extra: StoryViewerArgs(
        stories: List<ExploreStory>.from(state.stories),
        initialStoryIndex: viewerIndex,
        onStoriesUpdated: _updateStories,
      ),
    );
  }

  void _updateStories(List<ExploreStory> updated) {
    state = state.copyWith(stories: updated);
    notifyListeners();
    args.onStoriesUpdated(updated);
  }
}
