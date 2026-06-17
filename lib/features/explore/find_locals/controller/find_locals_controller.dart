import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/explore/repository/explore_repository.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../../explore/model/explore_model.dart';
import '../model/find_locals_args.dart';
import '../model/find_locals_model.dart';
import '../repository/find_locals_repository.dart';

class FindLocalsController extends ChangeNotifier {
  final FindLocalsRepository repo;
  final FindLocalsArgs args;
  FindLocalsModel state;

  FindLocalsController(this.repo, this.args)
      : state = FindLocalsModel(
          users: repo.buildUsers(args.followLocals),
          stories: List<ExploreStory>.from(args.stories),
        );

  void toggleFollow(String id) {
    state = state.copyWith(
      users: state.users
          .map(
            (user) => user.id == id
                ? user.copyWith(isFollowing: !user.isFollowing)
                : user,
          )
          .toList(),
    );
    notifyListeners();
    _syncFollowLocals();
  }

  void _syncFollowLocals() {
    final byId = {for (final user in state.users) user.id: user};
    args.onFollowLocalsUpdated(
      args.followLocals
          .map((user) => byId[user.id] ?? user)
          .toList(),
    );
  }

  void openProfile(BuildContext context) {
    context.push('/view_profile');
  }

  bool hasStory(String userId) => UserStoryLauncher.hasStory(userId);

  bool isStoryViewed(String userId) => UserStoryLauncher.isViewed(userId);

  ExploreStory? storyForUser(String userId) {
    final story = UserStoryLauncher.storyFor(userId);
    return story != null && story.hasStory ? story : null;
  }

  Future<void> openUserStory(BuildContext context, String userId) async {
    if (!hasStory(userId)) return;

    await UserStoryLauncher.open(context, userId);
    _updateStories(ExploreRepositoryImpl.instance.loadStories());
  }

  void _updateStories(List<ExploreStory> updated) {
    state = state.copyWith(stories: updated);
    notifyListeners();
    args.onStoriesUpdated(updated);
  }
}
