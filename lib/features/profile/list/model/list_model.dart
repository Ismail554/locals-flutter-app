enum ListTab { followers, following }

class ListUser {
  final String id;
  final String name;
  final int level;
  final bool followsYou;
  final bool isFollowing;
  final String? avatarUrl;

  const ListUser({
    required this.id,
    required this.name,
    required this.level,
    this.followsYou = false,
    this.isFollowing = false,
    this.avatarUrl,
  });

  ListUser copyWith({bool? isFollowing}) {
    return ListUser(
      id: id,
      name: name,
      level: level,
      followsYou: followsYou,
      isFollowing: isFollowing ?? this.isFollowing,
      avatarUrl: avatarUrl,
    );
  }

  /// Maps a `/social/followers/` or `/social/following/` API item.
  factory ListUser.fromApi(Map<String, dynamic> json) {
    return ListUser(
      id: json['id'].toString(),
      name: json['full_name'] as String? ?? '',
      level: json['level'] as int? ?? 1,
      followsYou: json['follows_you'] as bool? ?? false,
      isFollowing: json['is_following'] as bool? ?? false,
      avatarUrl: json['avatar'] as String?,
    );
  }
}

class ListModel {
  final ListTab selectedTab;
  final List<ListUser> followers;
  final List<ListUser> following;
  final bool isLoading;
  final String? errorMessage;

  const ListModel({
    this.selectedTab = ListTab.followers,
    this.followers = const [],
    this.following = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  /// Real counts driven by loaded data — accessible anywhere ListModel is
  /// available (e.g. `controller.state.followersCount`).
  int get followersCount => followers.length;
  int get followingCount => following.length;

  List<ListUser> get activeUsers =>
      selectedTab == ListTab.followers ? followers : following;

  ListModel copyWith({
    ListTab? selectedTab,
    List<ListUser>? followers,
    List<ListUser>? following,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ListModel(
      selectedTab: selectedTab ?? this.selectedTab,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}