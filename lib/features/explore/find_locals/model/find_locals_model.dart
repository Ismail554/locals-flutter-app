import '../../explore/model/explore_model.dart';

class FindLocalsModel {
  final List<ExploreFollowUser> users;
  final List<ExploreStory> stories;
  final bool isLoading;
  final String? errorMessage;

  const FindLocalsModel({
    required this.users,
    required this.stories,
    this.isLoading = false,
    this.errorMessage,
  });

  FindLocalsModel copyWith({
    List<ExploreFollowUser>? users,
    List<ExploreStory>? stories,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FindLocalsModel(
      users: users ?? this.users,
      stories: stories ?? this.stories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}