import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/explore/repository/explore_repository.dart';
import 'package:locals/features/rank/view_profile/model/view_profile_args.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../../explore/model/explore_model.dart';
import '../model/find_locals_args.dart';
import '../model/find_locals_model.dart';
import '../repository/find_locals_repository.dart';

class FindLocalsController extends ChangeNotifier {
  final FindLocalsRepository repo;
  final FindLocalsArgs args;
  FindLocalsModel state;

  FindLocalsController(this.repo, this.args)
    : state = FindLocalsModel(
        users: const [],
        stories: List<ExploreStory>.from(args.stories),
        isLoading: true,
      ) {
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      final users = await repo.fetchSuggestions();

      // Sync with any follow-state changes
      final followById = {for (final u in args.followLocals) u.id: u};
      final synced = users.map((user) {
        final existing = followById[user.id];
        return existing != null
            ? user.copyWith(isFollowing: existing.isFollowing)
            : user;
      }).toList();

      state = state.copyWith(users: synced, isLoading: false);
    } catch (e) {
      print('Find locals suggestions error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load suggestions. Please try again.',
      );
    }

    notifyListeners();
  }

  Future<void> refresh() => _loadSuggestions();

  Future<void> toggleFollow(String id) async {
    final target = state.users.firstWhere((u) => u.id == id);
    final wasFollowing = target.isFollowing;

    // Optimistic update
    state = state.copyWith(
      users: state.users
          .map(
            (user) => user.id == id
                ? user.copyWith(isFollowing: !wasFollowing)
                : user,
          )
          .toList(),
    );
    notifyListeners();
    _syncFollowLocals();

    try {
      await repo.toggleFollow(id);
    } catch (e) {
      print('Toggle follow error: $e');
      // Rollback on failure
      state = state.copyWith(
        users: state.users
            .map(
              (user) => user.id == id
                  ? user.copyWith(isFollowing: wasFollowing)
                  : user,
            )
            .toList(),
      );
      notifyListeners();
      _syncFollowLocals();
    }
  }

  void _syncFollowLocals() {
    final byId = {for (final user in state.users) user.id: user};
    args.onFollowLocalsUpdated(
      args.followLocals.map((user) => byId[user.id] ?? user).toList(),
    );
  }

  void openProfile(BuildContext context, String userId) {
    context.push('/view_profile', extra: ViewProfileArgs(userId: userId));
  }

  bool hasStory(String userId) => UserStoryLauncher.hasStory(userId);

  bool isStoryViewed(String userId) => UserStoryLauncher.isViewed(userId);

  ExploreStory? storyForUser(String userId) {
    final story = UserStoryLauncher.storyFor(userId);
    return story != null && story.hasStory ? story : null;
  }

  Future<void> openUserStory(BuildContext context, String userId) async {
    if (!hasStory(userId)) return;

    await UserStoryLauncher.open(context, userId);
    _updateStories(ExploreRepositoryImpl.instance.loadStories());
  }

  void _updateStories(List<ExploreStory> updated) {
    state = state.copyWith(stories: updated);
    notifyListeners();
    args.onStoriesUpdated(updated);
  }
}
