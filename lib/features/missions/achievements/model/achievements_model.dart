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

  const AchievementsModel({
    this.achievements = const [
      AchievementItem(
        id: 'first_local',
        title: 'First Local',
        subtitle: 'Make your first check-in.',
        emoji: '🌱',
        isUnlocked: true,
      ),
      AchievementItem(
        id: 'ten_visits',
        title: '10 Visits',
        subtitle: 'Visit 10 authentic places.',
        emoji: '📍',
        isUnlocked: true,
      ),
      AchievementItem(
        id: 'cafe_connoisseur',
        title: 'Café Connoisseur',
        subtitle: 'Visit 5 cafés with the seal.',
        emoji: '☕',
        isUnlocked: true,
      ),
      AchievementItem(
        id: 'night_owl',
        title: 'Night Owl',
        subtitle: 'Check in after 22:00.',
        emoji: '🌙',
        isUnlocked: true,
      ),
      AchievementItem(
        id: 'fifty_visits',
        title: '50 Visits',
        subtitle: 'Reach 50 visited places.',
        emoji: '🔒',
        isUnlocked: false,
      ),
      AchievementItem(
        id: 'city_complete',
        title: 'City Complete',
        subtitle: '100% completion in any city.',
        emoji: '🔒',
        isUnlocked: false,
      ),
      AchievementItem(
        id: 'globetrotter',
        title: 'Globetrotter',
        subtitle: 'Visit places in 3 cities.',
        emoji: '🔒',
        isUnlocked: false,
      ),
      AchievementItem(
        id: 'mission_master',
        title: 'Mission Master',
        subtitle: 'Complete 25 missions.',
        emoji: '🔒',
        isUnlocked: false,
      ),
    ],
  });

  int get unlockedCount =>
      achievements.where((achievement) => achievement.isUnlocked).length;

  int get totalCount => achievements.length;
}
