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
        ) {
    _loadStoryFeed();
    _loadDashboard();
  }

  // ─── Dashboard ──────────────────────────────────────────────────────────────

  Future<void> _loadDashboard() async {
    state = state.copyWith(isLoadingDashboard: true);
    notifyListeners();

    try {
      final dashboard = await repo.fetchDashboard();
      state = state.copyWith(
        localShares: dashboard.localShares,
        followLocals: dashboard.suggestedUsers,
        featuredLocations: dashboard.featuredLocations,
        newLocals: dashboard.newLocals,
        featuredRoute: dashboard.featuredRoutes.isNotEmpty
            ? dashboard.featuredRoutes.first
            : null,
        isLoadingDashboard: false,
      );
    } catch (e) {
      print('Dashboard load error: $e');
      state = state.copyWith(isLoadingDashboard: false);
    }

    notifyListeners();
  }

  Future<void> refreshDashboard() => _loadDashboard();

  // ─── Story Feed ─────────────────────────────────────────────────────────────

  Future<void> _loadStoryFeed() async {
    state = state.copyWith(isLoadingStories: true);
    notifyListeners();

    try {
      final feedStories = await repo.fetchStoryFeed();
      final yourStory = repo.loadStories().first;
      state = state.copyWith(
        stories: [yourStory, ...feedStories],
        isLoadingStories: false,
      );
    } catch (e) {
      print('Story feed error: $e');
      state = state.copyWith(isLoadingStories: false);
    }

    notifyListeners();
  }

  // ─── Story Tap ──────────────────────────────────────────────────────────────

  Future<void> onStoryTap(BuildContext context, int index) async {
    final story = state.stories[index];
    if (story.isYourStory) {
      await _onYourStoryTap(context, story);
      return;
    }
    if (!story.hasStory) return;
    await openStoryViewer(context, index);
  }

  Future<void> _onYourStoryTap(
      BuildContext context, ExploreStory story) async {
    if (!story.hasStory) {
      await _pickAndUploadStory(context);
      return;
    }

    final action = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: Text(ctx.l10n.exploreViewYourStory),
              onTap: () => Navigator.pop(ctx, 'view'),
            ),
            ListTile(
              leading: const Icon(Icons.add_photo_alternate_outlined),
              title: Text(ctx.l10n.exploreAddPhoto),
              onTap: () => Navigator.pop(ctx, 'add'),
            ),
          ],
        ),
      ),
    );

    if (!context.mounted) return;
    switch (action) {
      case 'view':
        await openStoryViewer(context, 0);
      case 'add':
        await _pickAndUploadStory(context);
    }
  }

  Future<void> _pickAndUploadStory(BuildContext context) async {
    try {
      final slide = await storyUploadService.pickAndUpload(context, repo);
      if (slide == null) return;

      repo.addSlideToYourStory(slide);
      final yourStory = repo.loadStories().first;
      state = state.copyWith(
        stories: [yourStory, ...state.stories.where((s) => !s.isYourStory)],
      );
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.snackbarStoryAdded)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to upload story. Please try again.')),
        );
      }
    }
  }

  // ─── Story Viewer ───────────────────────────────────────────────────────────

  Future<void> openStoryViewer(BuildContext context, int initialIndex) async {
    final storiesWithContent = state.stories.where((s) => s.hasStory).toList();
    if (storiesWithContent.isEmpty) return;

    final story = state.stories[initialIndex];
    final viewerIndex = storiesWithContent.indexWhere((s) => s.id == story.id);
    if (viewerIndex < 0) return;

    if (!story.isYourStory) {
      _markStoriesViewed(story);
    }

    await context.push(
      '/story_view',
      extra: StoryViewerArgs(
        stories: List<ExploreStory>.from(state.stories),
        initialStoryIndex: viewerIndex,
        onStoriesUpdated: _updateStories,
      ),
    );

    final yourStory = repo.loadStories().first;
    state = state.copyWith(
      stories: [yourStory, ...state.stories.where((s) => !s.isYourStory)],
    );
    notifyListeners();
  }

  void _markStoriesViewed(ExploreStory story) {
    for (final slide in story.activeSlides) {
      repo.markStoryViewed(slide.id).catchError((dynamic e) {
        print('Mark viewed error (slide ${slide.id}): $e');
      });
    }

    state = state.copyWith(
      stories: state.stories
          .map((s) => s.id == story.id ? s.copyWith(isViewed: true) : s)
          .toList(),
    );
    notifyListeners();
  }

  void openUserStory(BuildContext context, String userId) {
    final index = state.stories.indexWhere((s) => s.id == userId);
    if (index < 0 || !state.stories[index].hasStory) return;
    openStoryViewer(context, index);
  }

  void _updateStories(List<ExploreStory> updated) {
    repo.saveStories(updated);
    final yourStory = repo.loadStories().first;
    state = state.copyWith(
      stories: [yourStory, ...updated.where((s) => !s.isYourStory)],
    );
    notifyListeners();
  }

  // ─── Local Shares ───────────────────────────────────────────────────────────

  Future<void> toggleLocalShareLike(ExploreLocalShare share) async {
    // Optimistic update first
    final wasLiked = share.isLikedByUser;
    state = state.copyWith(
      localShares: state.localShares.map((s) {
        if (s.id != share.id) return s;
        return s.copyWith(
          isLikedByUser: !wasLiked,
          likeCount: wasLiked ? s.likeCount - 1 : s.likeCount + 1,
        );
      }).toList(),
    );
    notifyListeners();

    try {
      await repo.likeLocalShare(share.id);
    } catch (e) {
      // Revert on failure
      print('Like local share error: $e');
      state = state.copyWith(
        localShares: state.localShares.map((s) {
          return s.id == share.id ? share : s;
        }).toList(),
      );
      notifyListeners();
    }
  }

  // ─── Navigation ─────────────────────────────────────────────────────────────

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

  void openFeaturedLocations(BuildContext context) =>
      context.push('/featured_locations');

  void openEventsRoutes(BuildContext context) =>
      context.push('/events_routes');

  void openLocationDetails(BuildContext context, String locationId) {
    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: locationId),
    );
  }

  void openJoinEvent(BuildContext context, String eventId) {
    context.push('/join_event', extra: JoinEventArgs(eventId: eventId));
  }

  void openNotifications(BuildContext context) =>
      context.push('/notification');

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

  void openLocalShares(BuildContext context) => context.push('/local_shares');

  void openProfile(BuildContext context) => context.push('/view_profile');

  void toggleFollow(String id) {
    state = state.copyWith(
      followLocals: state.followLocals
          .map((u) => u.id == id
              ? u.copyWith(isFollowing: !u.isFollowing)
              : u)
          .toList(),
    );
    notifyListeners();
  }
}