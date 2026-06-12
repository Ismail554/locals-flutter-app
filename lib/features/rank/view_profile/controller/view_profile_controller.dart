import 'package:flutter/material.dart';
import '../model/view_profile_model.dart';
import '../repository/view_profile_repository.dart';

class ViewProfileController extends ChangeNotifier {
  final ViewProfileRepository repo;
  ViewProfileModel state = const ViewProfileModel();

  ViewProfileController(this.repo);

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
}
