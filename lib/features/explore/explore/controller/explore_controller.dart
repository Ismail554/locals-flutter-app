import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import '../../explore/service/story_upload_service.dart';
import '../model/explore_model.dart';
import '../repository/explore_repository.dart';
import '../../find_locals/model/find_locals_args.dart';
import '../../join_event/model/join_event_args.dart';
import '../../restaurant_view_details/model/restaurant_view_details_args.dart';
import '../../story_view/model/story_view_args.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ExploreController extends ChangeNotifier {
  final ExploreRepository repo;
  final StoryUploadService storyUploadService;
  ExploreModel state;

  ExploreController(this.repo, {StoryUploadService? storyUploadService})
    : storyUploadService = storyUploadService ?? StoryUploadService(),
      state = ExploreModel(
        stories: repo.loadStories(),
        localShares: _getDefaultLocalShares(), // ← Added
      );

  // NEW: Default Local Shares to match screenshot
  static List<ExploreLocalShare> _getDefaultLocalShares() {
    return [
      ExploreLocalShare(
        id: 'ls1',
        imageColor: const Color(0xFFFFE4C4),
        userName: 'Marta Roig',
        userAvatarInitial: 'M',
        timeAgo: '2d ago',
        caption: 'Best cortado in the Born.',
        likeCount: 24,
      ),
      ExploreLocalShare(
        id: 'ls2',
        imageColor: const Color(0xFFB0C4DE),
        userName: 'Joan Bosch',
        userAvatarInitial: 'J',
        timeAgo: '5h ago',
        caption: 'Tokyo Skytree at sunset.',
        likeCount: 42,
      ),
      ExploreLocalShare(
        id: 'ls3',
        imageColor: const Color(0xFF4682B4),
        userName: 'Aina V.',
        userAvatarInitial: 'A',
        timeAgo: '1d ago',
        caption: 'Cozy evening at the bar.',
        likeCount: 19,
      ),
      ExploreLocalShare(
        id: 'ls4',
        imageColor: const Color(0xFFD2B48C),
        userName: 'Marta Roig',
        userAvatarInitial: 'M',
        timeAgo: '3h ago',
        caption: 'Fresh pastries for breakfast.',
        likeCount: 31,
      ),
      ExploreLocalShare(
        id: 'ls5',
        imageColor: const Color(0xFFFFDAB9),
        userName: 'Joan Bosch',
        userAvatarInitial: 'J',
        timeAgo: '12h ago',
        caption: 'Tapas night with friends.',
        likeCount: 28,
      ),
      ExploreLocalShare(
        id: 'ls6',
        imageColor: const Color(0xFF708090),
        userName: 'Aina V.',
        userAvatarInitial: 'A',
        timeAgo: 'Yesterday',
        caption: 'Beautiful restaurant interior.',
        likeCount: 15,
      ),
    ];
  }

  void openLocalShareDetails(BuildContext context, ExploreLocalShare share) {
    final photo = CheckInPhoto(
      previewColor: share.imageColor,
      locationName: share.userName,
      timeAgo: share.timeAgo,
      caption: share.caption,
      likes: share.likeCount,
      userInitial: share.userAvatarInitial,
    );

    ImageViewDialog.show(context, photo, viewType: ImageViewType.localShare);
  }

  void openFeaturedLocations(BuildContext context) {
    context.push('/featured_locations');
  }

  void openEventsRoutes(BuildContext context) {
    context.push('/events_routes');
  }

  void openLocationDetails(BuildContext context, String locationId) {
    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: locationId),
    );
  }

  void openJoinEvent(BuildContext context, String eventId) {
    context.push('/join_event', extra: JoinEventArgs(eventId: eventId));
  }

  void openNotifications(BuildContext context) {
    context.push('/notification');
  }

  void openFindLocals(BuildContext context) {
    context.push(
      '/find_locals',
      extra: FindLocalsArgs(
        followLocals: List<ExploreFollowUser>.from(state.followLocals),
        stories: List<ExploreStory>.from(state.stories),
        onFollowLocalsUpdated: (users) {
          state = state.copyWith(followLocals: users);
          notifyListeners();
        },
        onStoriesUpdated: _updateStories,
      ),
    );
  }

  void openLocalShares(BuildContext context) {
    context.push('/local_shares');
  }

  void openProfile(BuildContext context) {
    context.push('/view_profile');
  }

  void openUserStory(BuildContext context, String userId) {
    final index = state.stories.indexWhere((story) => story.id == userId);
    if (index < 0) return;
    if (!state.stories[index].hasStory) return;
    openStoryViewer(context, index);
  }

  void toggleFollow(String id) {
    state = state.copyWith(
      followLocals: state.followLocals
          .map(
            (user) => user.id == id
                ? user.copyWith(isFollowing: !user.isFollowing)
                : user,
          )
          .toList(),
    );
    notifyListeners();
  }

  Future<void> onStoryTap(BuildContext context, int index) async {
    final story = state.stories[index];
    if (story.isYourStory) {
      await _onYourStoryTap(context, story);
      return;
    }
    if (!story.hasStory) return;
    openStoryViewer(context, index);
  }

  Future<void> _onYourStoryTap(BuildContext context, ExploreStory story) async {
    if (!story.hasStory) {
      await _pickAndAddStoryImage(context);
      return;
    }

    final action = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: Text(context.l10n.exploreViewYourStory),
              onTap: () => Navigator.pop(context, 'view'),
            ),
            ListTile(
              leading: const Icon(Icons.add_photo_alternate_outlined),
              title: Text(context.l10n.exploreAddPhoto),
              onTap: () => Navigator.pop(context, 'add'),
            ),
          ],
        ),
      ),
    );

    if (!context.mounted) return;
    switch (action) {
      case 'view':
        openStoryViewer(context, 0);
      case 'add':
        await _pickAndAddStoryImage(context);
    }
  }

  Future<void> _pickAndAddStoryImage(BuildContext context) async {
    final slide = await storyUploadService.pickFromGallery(context);
    if (slide == null) return;

    repo.addSlideToYourStory(slide);
    state = state.copyWith(stories: repo.loadStories());
    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.snackbarStoryAdded)));
    }
  }

  Future<void> openStoryViewer(BuildContext context, int initialIndex) async {
    final storiesWithContent = state.stories.where((s) => s.hasStory).toList();
    if (storiesWithContent.isEmpty) return;

    final story = state.stories[initialIndex];
    final viewerIndex = storiesWithContent.indexWhere((s) => s.id == story.id);
    if (viewerIndex < 0) return;

    await context.push(
      '/story_view',
      extra: StoryViewerArgs(
        stories: List<ExploreStory>.from(state.stories),
        initialStoryIndex: viewerIndex,
        onStoriesUpdated: _updateStories,
      ),
    );

    state = state.copyWith(stories: repo.loadStories());
    notifyListeners();
  }

  void _updateStories(List<ExploreStory> updated) {
    repo.saveStories(updated);
    state = state.copyWith(stories: updated);
    notifyListeners();
  }
}
