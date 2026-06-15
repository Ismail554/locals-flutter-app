import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';
import '../view/widgets/share_profile_bottom_sheet.dart';

class ProfileController extends ChangeNotifier {
  final ProfileRepository repo;
  ProfileModel state = const ProfileModel();

  ProfileController(this.repo);

  void openSettings(BuildContext context) {
    context.push('/settings');
  }

  void openMyMap(BuildContext context) {
    context.push('/my_map');
  }

  void openBlockedList(BuildContext context) {
    context.push('/blocked_list');
  }

  void openFollowersList(BuildContext context) {
    context.push('/list');
  }

  void openSavedPlaces(BuildContext context) {
    context.push('/saved_places');
  }

  void shareProfile(BuildContext context) {
    ShareProfileBottomSheet.show(
      context,
      name: state.name,
      level: state.level,
      avatarColor: const Color(0xFFD4A574),
      shareUrl: state.shareUrl,
    );
  }
}
