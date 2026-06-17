import 'package:flutter/material.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/view_profile_model.dart';
import '../repository/view_profile_repository.dart';

class ViewProfileController extends ChangeNotifier {
  final ViewProfileRepository repo;
  ViewProfileModel state;

  ViewProfileController(this.repo, {String? userId})
      : state = repo.load(userId ?? 'marta');

  bool get hasStory => UserStoryLauncher.hasStory(state.storyUserId);

  bool get isStoryViewed => UserStoryLauncher.isViewed(state.storyUserId);

  void selectTab(ViewProfileTab tab) {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();
  }

  void toggleFollow() {
    state = state.copyWith(isFollowing: !state.isFollowing);
    notifyListeners();
  }

  void blockUser(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block user'),
        content: Text('Block ${state.name}? They will not be able to see your profile.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void openPhoto(BuildContext context, CheckInPhoto photo) {
    ImageViewDialog.show(context, photo);
  }

  Future<void> openStory(BuildContext context) async {
    final storyUserId = state.storyUserId;
    if (storyUserId == null || !hasStory) return;
    await UserStoryLauncher.open(context, storyUserId);
    notifyListeners();
  }
}
