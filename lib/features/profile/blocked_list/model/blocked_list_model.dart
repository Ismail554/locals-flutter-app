class BlockedUser {
  final String id;
  final String name;
  final int level;
  final String? avatarUrl;

  const BlockedUser({
    required this.id,
    required this.name,
    required this.level,
    this.avatarUrl,
  });

  /// Maps a `/social/blocked/` API item.
  factory BlockedUser.fromApi(Map<String, dynamic> json) {
    return BlockedUser(
      id: json['id'].toString(),
      name: json['full_name'] as String? ?? '',
      level: json['level'] as int? ?? 1,
      avatarUrl: json['avatar'] as String?,
    );
  }
}

class BlockedListModel {
  final List<BlockedUser> users;
  final bool isLoading;
  final String? errorMessage;

  const BlockedListModel({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  BlockedListModel copyWith({
    List<BlockedUser>? users,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BlockedListModel(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}