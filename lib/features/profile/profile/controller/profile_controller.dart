import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/user_session.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';
import '../view/widgets/share_profile_bottom_sheet.dart';

class ProfileController extends ChangeNotifier {
  final ProfileRepository repo;
  ProfileModel state = const ProfileModel();

  bool isLoading = false;
  String? errorMessage;

  ProfileController(this.repo) {
    load();
  }

  static const _storyUserId = 'you';

  bool get hasStory => UserStoryLauncher.hasStory(_storyUserId);

  bool get isStoryViewed => UserStoryLauncher.isViewed(_storyUserId);

  Future<void> load({int? userId}) async {
    final id = userId ?? UserSession().currentUser?.id;
    if (id == null) {
      errorMessage = 'No logged in user found.';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        repo.fetchProfile(id),
        repo.fetchAchievements(id),
        repo.fetchCheckins(id),
      ]);
       print('achievements raw: ${results[1]}');
  print('checkins raw: ${results[2]}');


      state = ProfileModel.fromApi(
        profileJson: results[0] as Map<String, dynamic>,
        achievementsJson: results[1] as List<dynamic>,
        checkinsJson: results[2] as List<dynamic>,
      );
      print('parsed achievements: ${state.achievements.length}');
  print('parsed visits: ${state.latestVisits.length}');
    } catch (e) {
      print('PARSE ERROR: $e');
      errorMessage = 'Failed to load profile: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> openStory(BuildContext context) async {
    if (!hasStory) return;
    await UserStoryLauncher.open(context, _storyUserId);
    notifyListeners();
  }

  void openSettings(BuildContext context) => context.push('/settings');
  void openMyMap(BuildContext context) => context.push('/my_map');
  void openBlockedList(BuildContext context) => context.push('/blocked_list');
  void openFollowersList(BuildContext context) => context.push('/list');
  void openSavedPlaces(BuildContext context) => context.push('/saved_places');
  void openAchievements(BuildContext context) => context.push('/achievements');

  void shareProfile(BuildContext context) {
    ShareProfileBottomSheet.show(
      context,
      name: state.name,
      level: state.level,
      avatarColor: const Color(0xFFD4A574),
      shareUrl: state.shareUrl,
    );
  }

  void openVisitImage(BuildContext context, CheckInPhoto photo) {
    ImageViewDialog.show(context, photo, viewType: ImageViewType.checkIn);
  }
}