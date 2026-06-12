import '../../explore/model/explore_model.dart';

class FindLocalsModel {
  final List<ExploreFollowUser> users;
  final List<ExploreStory> stories;

  const FindLocalsModel({
    required this.users,
    required this.stories,
  });

  FindLocalsModel copyWith({
    List<ExploreFollowUser>? users,
    List<ExploreStory>? stories,
  }) {
    return FindLocalsModel(
      users: users ?? this.users,
      stories: stories ?? this.stories,
    );
  }
}
