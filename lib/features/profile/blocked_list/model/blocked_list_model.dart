class BlockedUser {
  final String id;
  final String name;
  final int level;

  const BlockedUser({
    required this.id,
    required this.name,
    required this.level,
  });
}

class BlockedListModel {
  final List<BlockedUser> users;

  const BlockedListModel({
    this.users = const [
      BlockedUser(id: 'tena', name: 'Tena', level: 9),
      BlockedUser(id: 'aina', name: 'Aina', level: 9),
      BlockedUser(id: 'anna', name: 'Anna marie', level: 9),
    ],
  });

  BlockedListModel copyWith({List<BlockedUser>? users}) {
    return BlockedListModel(users: users ?? this.users);
  }
}
