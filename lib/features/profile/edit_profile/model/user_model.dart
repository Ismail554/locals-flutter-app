class UserSettings {
  final String language;
  final bool notifyMissions;
  final bool notifyEvents;
  final String profileVisibility;
  final String photoVisibility;
  final bool showOnLeaderboard;

  const UserSettings({
    this.language = 'en',
    this.notifyMissions = true,
    this.notifyEvents = true,
    this.profileVisibility = 'PUBLIC',
    this.photoVisibility = 'PUBLIC',
    this.showOnLeaderboard = true,
  });

  factory UserSettings.fromApi(Map<String, dynamic> json) {
    return UserSettings(
      language: json['language'] as String? ?? 'en',
      notifyMissions: json['notify_missions'] as bool? ?? true,
      notifyEvents: json['notify_events'] as bool? ?? true,
      profileVisibility: json['profile_visibility'] as String? ?? 'PUBLIC',
      photoVisibility: json['photo_visibility'] as String? ?? 'PUBLIC',
      showOnLeaderboard: json['show_on_leaderboard'] as bool? ?? true,
    );
  }
}

class UserModel {
  final int id;
  final String uuid;
  final String email;
  final String fullName;
  final String? avatarUrl;
  final int level;
  final int totalPoints;
  final String locationCity;
  final UserSettings settings;
  final int pointsToNextLevel;
  final int nextLevelThreshold;

  const UserModel({
    required this.id,
    required this.uuid,
    required this.email,
    required this.fullName,
    this.avatarUrl,
    this.level = 1,
    this.totalPoints = 0,
    this.locationCity = '',
    this.settings = const UserSettings(),
    this.pointsToNextLevel = 1000,
    this.nextLevelThreshold = 1000,
  });

  factory UserModel.fromApi(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      uuid: json['uuid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      avatarUrl: json['avatar'] as String?,
      level: json['level'] as int? ?? 1,
      totalPoints: json['total_points'] as int? ?? 0,
      locationCity: json['location_city'] as String? ?? '',
      settings: json['settings'] != null
          ? UserSettings.fromApi(json['settings'] as Map<String, dynamic>)
          : const UserSettings(),
      pointsToNextLevel: json['points_to_next_level'] as int? ?? 1000,
      nextLevelThreshold: json['next_level_threshold'] as int? ?? 1000,
    );
  }

  UserModel copyWith({
    String? fullName,
    String? locationCity,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id,
      uuid: uuid,
      email: email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      level: level,
      totalPoints: totalPoints,
      locationCity: locationCity ?? this.locationCity,
      settings: settings,
      pointsToNextLevel: pointsToNextLevel,
      nextLevelThreshold: nextLevelThreshold,
    );
  }
}