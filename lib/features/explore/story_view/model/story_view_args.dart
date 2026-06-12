import '../../explore/model/explore_model.dart';

class StoryViewerArgs {
  final List<ExploreStory> stories;
  final int initialStoryIndex;
  final void Function(List<ExploreStory> updatedStories)? onStoriesUpdated;

  const StoryViewerArgs({
    required this.stories,
    required this.initialStoryIndex,
    this.onStoriesUpdated,
  });
}
