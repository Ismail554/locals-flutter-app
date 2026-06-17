import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/list_model.dart';
import '../repository/list_repository.dart';

class ListController extends ChangeNotifier {
  final ListRepository repo;
  ListModel state = const ListModel();

  ListController(this.repo);

  void selectTab(ListTab tab) {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();
  }

  void toggleFollow(String id) {
    if (state.selectedTab == ListTab.followers) {
      state = state.copyWith(
        followers: state.followers
            .map((u) => u.id == id ? u.copyWith(isFollowing: !u.isFollowing) : u)
            .toList(),
      );
    } else {
      state = state.copyWith(
        following: state.following
            .map((u) => u.id == id ? u.copyWith(isFollowing: !u.isFollowing) : u)
            .toList(),
      );
    }
    notifyListeners();
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
