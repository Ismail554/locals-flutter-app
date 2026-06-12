enum ListTab { followers, following }

class ListUser {
  final String id;
  final String name;
  final int level;
  final bool followsYou;
  final bool isFollowing;

  const ListUser({
    required this.id,
    required this.name,
    required this.level,
    this.followsYou = false,
    this.isFollowing = false,
  });

  ListUser copyWith({bool? isFollowing}) {
    return ListUser(
      id: id,
      name: name,
      level: level,
      followsYou: followsYou,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

class ListModel {
  final ListTab selectedTab;
  final List<ListUser> followers;
  final List<ListUser> following;

  const ListModel({
    this.selectedTab = ListTab.followers,
    this.followers = const [
      ListUser(id: 'joan', name: 'Joan', level: 9),
      ListUser(id: 'pol', name: 'Pol', level: 9),
      ListUser(id: 'tena', name: 'Tena', level: 9),
      ListUser(id: 'aina', name: 'Aina', level: 9),
    ],
    this.following = const [
      ListUser(id: 'tena', name: 'Tena', level: 9, followsYou: true, isFollowing: true),
      ListUser(id: 'aina', name: 'Aina', level: 9, isFollowing: true),
      ListUser(id: 'anna', name: 'Anna marie', level: 9, isFollowing: true),
    ],
  });

  int get followersCount => 128;
  int get followingCount => 96;

  List<ListUser> get activeUsers =>
      selectedTab == ListTab.followers ? followers : following;

  ListModel copyWith({
    ListTab? selectedTab,
    List<ListUser>? followers,
    List<ListUser>? following,
  }) {
    return ListModel(
      selectedTab: selectedTab ?? this.selectedTab,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
