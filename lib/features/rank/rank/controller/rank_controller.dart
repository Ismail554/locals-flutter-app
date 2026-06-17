import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/rank_model.dart';
import '../repository/rank_repository.dart';

class RankController extends ChangeNotifier {
  final RankRepository repo;
  RankModel state = const RankModel();

  RankController(this.repo);

  void selectScope(RankScope scope) {
    state = state.copyWith(selectedScope: scope);
    notifyListeners();
  }

  void selectPeriod(RankPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    notifyListeners();
  }

  void openViewProfile(BuildContext context) {
    context.push('/view_profile');
  }

  bool hasStory(String? storyUserId) => UserStoryLauncher.hasStory(storyUserId);

  bool isStoryViewed(String? storyUserId) =>
      UserStoryLauncher.isViewed(storyUserId);

  Future<void> openUserStory(BuildContext context, String? storyUserId) async {
    if (storyUserId == null) return;
    await UserStoryLauncher.open(context, storyUserId);
    notifyListeners();
  }

  void onPodiumAvatarTap(BuildContext context, PodiumUser user) {
    if (hasStory(user.storyUserId)) {
      openUserStory(context, user.storyUserId);
    }
  }

  void onListAvatarTap(BuildContext context, RankEntry entry) {
    if (hasStory(entry.storyUserId)) {
      openUserStory(context, entry.storyUserId);
    }
  }
}
