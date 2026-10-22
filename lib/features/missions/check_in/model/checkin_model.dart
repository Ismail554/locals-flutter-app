class CheckInAchievement {
  final int id;
  final String title;
  final int pointsAwarded;
  final String iconUrl;

  const CheckInAchievement({
    required this.id,
    required this.title,
    required this.pointsAwarded,
    required this.iconUrl,
  });

  factory CheckInAchievement.fromJson(Map<String, dynamic> json) {
    return CheckInAchievement(
      id: _asInt(json['id']),
      title: json['title']?.toString() ?? '',
      pointsAwarded: _asInt(json['points_awarded']),
      iconUrl: json['icon_url']?.toString() ?? '',
    );
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class CheckInResult {
  final bool success;
  final String message;

  final String? postImageUrl;
  final String? caption;

  /// success | already_checked_in
  final String gamificationStatus;

  final int pointsEarned;
  final int newTotalPoints;
  final int newLevel;
  final double cityCompletionPercentage;
  final bool missionCompleted;
  final List<CheckInAchievement> unlockedAchievements;

  const CheckInResult({
    required this.success,
    required this.message,
    this.postImageUrl,
    this.caption,
    required this.gamificationStatus,
    required this.pointsEarned,
    required this.newTotalPoints,
    required this.newLevel,
    required this.cityCompletionPercentage,
    required this.missionCompleted,
    required this.unlockedAchievements,
  });

  bool get isAlreadyCheckedIn =>
      gamificationStatus == 'already_checked_in';

  bool get isGamificationSuccess =>
      gamificationStatus == 'success';

  factory CheckInResult.fromJson(Map<String, dynamic> json) {
    final post = json['post'] as Map<String, dynamic>? ?? {};
    final gamification =
        json['gamification'] as Map<String, dynamic>? ?? {};

    final achievements =
        gamification['unlocked_achievements'] as List<dynamic>? ?? [];

    return CheckInResult(
      success: json['success'] as bool? ?? false,
      message: json['message']?.toString() ?? '',

      postImageUrl: post['image']?.toString(),
      caption: post['caption']?.toString(),

      gamificationStatus:
          gamification['status']?.toString() ?? '',

      pointsEarned: _asInt(gamification['points_earned']),
      newTotalPoints: _asInt(gamification['new_total_points']),
      newLevel: _asInt(gamification['new_level']),

      cityCompletionPercentage:
          (gamification['city_completion_percentage'] as num?)
                  ?.toDouble() ??
              0,

      missionCompleted:
          gamification['mission_completed'] as bool? ?? false,

      unlockedAchievements: achievements
          .map((e) => CheckInAchievement.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}