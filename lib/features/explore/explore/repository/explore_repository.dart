import '../model/explore_model.dart';

abstract class ExploreRepository {
  List<ExploreStory> loadStories();
  void saveStories(List<ExploreStory> stories);
  void addSlideToYourStory(StorySlide slide);
}

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl._();

  static final ExploreRepositoryImpl instance = ExploreRepositoryImpl._();

  List<ExploreStory> _stories =
      List<ExploreStory>.from(ExploreModel.defaultStories);

  @override
  List<ExploreStory> loadStories() => List<ExploreStory>.from(_stories);

  @override
  void saveStories(List<ExploreStory> stories) {
    _stories = List<ExploreStory>.from(stories);
  }

  @override
  void addSlideToYourStory(StorySlide slide) {
    _stories = _stories.map((story) {
      if (story.isYourStory) {
        return story.copyWith(slides: [...story.slides, slide]);
      }
      return story;
    }).toList();
  }
}
