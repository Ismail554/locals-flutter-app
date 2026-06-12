import '../../explore/model/explore_model.dart';

class FindLocalsArgs {
  final List<ExploreFollowUser> followLocals;
  final List<ExploreStory> stories;
  final void Function(List<ExploreFollowUser>) onFollowLocalsUpdated;
  final void Function(List<ExploreStory>) onStoriesUpdated;

  const FindLocalsArgs({
    required this.followLocals,
    required this.stories,
    required this.onFollowLocalsUpdated,
    required this.onStoriesUpdated,
  });
}
