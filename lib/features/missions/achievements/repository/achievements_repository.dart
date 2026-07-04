import 'package:locals/core/network/api_client.dart';
import '../model/achievements_model.dart';

abstract class AchievementsRepository {
  Future<AchievementsModel> fetchAchievements();
}

class AchievementsRepositoryImpl implements AchievementsRepository {
  final ApiClient _client = ApiClient();

  static const String _lockedEmoji = '🔒';
  static const String _unlockedEmoji = '🏆';

  @override
  Future<AchievementsModel> fetchAchievements() async {
    final response = await _client.get('/gamification/achievements/');

    final List<dynamic> rawAchievements =
        (response['achievements'] as List<dynamic>?) ?? [];

    final items = rawAchievements.map((raw) {
      final map = raw as Map<String, dynamic>;
      final isUnlocked = map['is_unlocked'] as bool? ?? false;

      return AchievementItem(
        id: map['id'].toString(),
        title: map['title'] as String? ?? '',
        subtitle: map['description'] as String? ?? '',
        emoji: isUnlocked ? _unlockedEmoji : _lockedEmoji,
        isUnlocked: isUnlocked,
      );
    }).toList();

    return AchievementsModel(achievements: items);
  }
}