class AchievementItem {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final bool isUnlocked;

  const AchievementItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.isUnlocked,
  });
}

class AchievementsModel {
  final List<AchievementItem> achievements;

  const AchievementsModel({this.achievements = const []});

  int get unlockedCount =>
      achievements.where((achievement) => achievement.isUnlocked).length;

  int get totalCount => achievements.length;
}