import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/list_model.dart';
import '../repository/list_repository.dart';

class ListController extends ChangeNotifier {
  final ListRepository repo;
  ListModel state = const ListModel(isLoading: true);

  ListController(this.repo) {
    _loadLists();
  }

  Future<void> _loadLists() async {
    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      final results = await Future.wait([
        repo.fetchFollowers(),
        repo.fetchFollowing(),
      ]);

      state = state.copyWith(
        followers: results[0],
        following: results[1],
        isLoading: false,
      );
    } catch (e) {
      print('List load error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load. Please try again.',
      );
    }

    notifyListeners();
  }

  Future<void> refresh() => _loadLists();

  void selectTab(ListTab tab) {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();
  }

  Future<void> toggleFollow(String id) async {
    final isFollowersTab = state.selectedTab == ListTab.followers;
    final list = isFollowersTab ? state.followers : state.following;
    final target = list.firstWhere((u) => u.id == id);
    final wasFollowing = target.isFollowing;

    // Optimistic update
    if (isFollowersTab) {
      state = state.copyWith(
        followers: state.followers
            .map((u) =>
                u.id == id ? u.copyWith(isFollowing: !wasFollowing) : u)
            .toList(),
      );
    } else {
      state = state.copyWith(
        following: state.following
            .map((u) =>
                u.id == id ? u.copyWith(isFollowing: !wasFollowing) : u)
            .toList(),
      );
    }
    notifyListeners();

    try {
      await repo.toggleFollow(id);
    } catch (e) {
      print('Toggle follow error: $e');
      // Rollback
      if (isFollowersTab) {
        state = state.copyWith(
          followers: state.followers
              .map((u) =>
                  u.id == id ? u.copyWith(isFollowing: wasFollowing) : u)
              .toList(),
        );
      } else {
        state = state.copyWith(
          following: state.following
              .map((u) =>
                  u.id == id ? u.copyWith(isFollowing: wasFollowing) : u)
              .toList(),
        );
      }
      notifyListeners();
    }
  }

  bool hasStory(String userId) => UserStoryLauncher.hasStory(userId);

  bool isStoryViewed(String userId) => UserStoryLauncher.isViewed(userId);

  Future<void> openUserStory(BuildContext context, String userId) async {
    if (!hasStory(userId)) return;
    await UserStoryLauncher.open(context, userId);
    notifyListeners();
  }

  void openViewProfile(BuildContext context) {
    context.push('/view_profile');
  }
}