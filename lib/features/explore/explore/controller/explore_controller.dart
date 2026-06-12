import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals/core/permissions/gallery_permission.dart';
import '../model/explore_model.dart';
import '../repository/explore_repository.dart';
import '../../find_locals/model/find_locals_args.dart';
import '../../story_view/model/story_view_args.dart';

class ExploreController extends ChangeNotifier {
  final ExploreRepository repo;
  ExploreModel state = ExploreModel();

  ExploreController(this.repo);

  final _imagePicker = ImagePicker();

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
              title: const Text('View your story'),
              onTap: () => Navigator.pop(context, 'view'),
            ),
            ListTile(
              leading: const Icon(Icons.add_photo_alternate_outlined),
              title: const Text('Add photo'),
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
    final hasPermission = await GalleryPermission.ensureGranted(context);
    if (!hasPermission || !context.mounted) return;

    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null) return;

    final slide = StorySlide(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: image.path,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      stories: state.stories.map((story) {
        if (story.isYourStory) {
          return story.copyWith(slides: [...story.slides, slide]);
        }
        return story;
      }).toList(),
    );
    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story added')),
      );
    }
  }

  void openStoryViewer(BuildContext context, int initialIndex) {
    final storiesWithContent = state.stories
        .where((s) => s.hasStory)
        .toList();
    if (storiesWithContent.isEmpty) return;

    final story = state.stories[initialIndex];
    final viewerIndex = storiesWithContent.indexWhere((s) => s.id == story.id);
    if (viewerIndex < 0) return;

    context.push(
      '/story_view',
      extra: StoryViewerArgs(
        stories: List<ExploreStory>.from(state.stories),
        initialStoryIndex: viewerIndex,
        onStoriesUpdated: _updateStories,
      ),
    );
  }

  void _updateStories(List<ExploreStory> updated) {
    state = state.copyWith(stories: updated);
    notifyListeners();
  }
}
