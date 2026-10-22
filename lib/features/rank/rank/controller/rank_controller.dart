import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/features/rank/view_profile/model/view_profile_args.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/rank_model.dart';
import '../repository/rank_repository.dart';

class RankController extends ChangeNotifier {
  final RankRepository repo;
  RankModel state = const RankModel();
  bool isLoading = false;

  RankController(this.repo) {
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    isLoading = true;
    notifyListeners();

    try {
      state = await repo.fetchLeaderboard(
        scope: state.selectedScope,
        period: state.selectedPeriod,
      );
    } catch (e) {
      debugPrint('Leaderboard fetch error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectScope(RankScope scope) {
    state = state.copyWith(selectedScope: scope);
    notifyListeners();
    fetchLeaderboard();
  }

  void selectPeriod(RankPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    notifyListeners();
    fetchLeaderboard();
  }

  void openViewProfile(BuildContext context, String userId) {
    context.push('/view_profile', extra: ViewProfileArgs(userId: userId));
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
