import 'package:flutter/material.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/view_profile_model.dart';
import '../repository/view_profile_repository.dart';

class ViewProfileController extends ChangeNotifier {
  final ViewProfileRepository repo;
  final String userId;
  ViewProfileModel state;
  bool isLoading = true;

  final ApiClient _client = ApiClient();

  ViewProfileController(this.repo, {required this.userId})
    : state = const ViewProfileModel() {
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      state = await repo.fetchProfile(userId);
    } catch (e) {
      debugPrint('ViewProfile fetch error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => _fetchProfile();

  bool get hasStory => UserStoryLauncher.hasStory(state.storyUserId);
  bool get isStoryViewed => UserStoryLauncher.isViewed(state.storyUserId);

  void selectTab(ViewProfileTab tab) {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();
  }

  Future<void> toggleFollow() async {
    try {
      await _client.post('/social/profiles/$userId/follow/', {});
      state = state.copyWith(isFollowing: !state.isFollowing);
      notifyListeners();
    } catch (e) {
      debugPrint('Follow toggle error: $e');
    }
  }

  Future<void> blockUser(BuildContext context) async {
    try {
      await repo.blockUser(userId);

      if (!context.mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User blocked successfully.')),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Block user error: $e');

      if (!context.mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to block user.')));
    }
  }

  void showMoreOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('More Options'),
        content: const Text('Block user or report?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => blockUser(context),
            child: const Text('Block', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void openPhoto(BuildContext context, CheckInPhoto photo) {
    ImageViewDialog.show(context, photo, viewType: ImageViewType.checkIn);
  }

  Future<void> openStory(BuildContext context) async {
    final storyUserId = state.storyUserId;
    if (storyUserId == null) return;
    await UserStoryLauncher.open(context, storyUserId);
    notifyListeners();
  }
}
