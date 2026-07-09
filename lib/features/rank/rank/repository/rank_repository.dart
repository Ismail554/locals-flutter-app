import 'package:locals/core/network/api_client.dart';
import '../model/rank_model.dart';

abstract class RankRepository {
  Future<RankModel> fetchLeaderboard({
    RankScope scope = RankScope.city,
    RankPeriod period = RankPeriod.weekly,
  });
}

class RankRepositoryImpl implements RankRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<RankModel> fetchLeaderboard({
    RankScope scope = RankScope.city,
    RankPeriod period = RankPeriod.weekly,
  }) async {
    // Build query parameters
    final queryParams = {
      'scope': _scopeToString(scope),
      'timeframe': _periodToString(period),
    };

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');

    final response = await _client.get('/gamification/leaderboard/?$queryString');

    final top3Raw = response['top_3'] as List<dynamic>? ?? [];
    final rankingsRaw = response['rankings'] as List<dynamic>? ?? [];
    final currentRaw = response['current_user'] as Map<String, dynamic>?;

    // Convert top 3 → Podium
    final podium = top3Raw.map((item) {
      final map = item as Map<String, dynamic>;
      return PodiumUser(
        rank: map['rank'] as int? ?? 0,
        name: map['full_name'] as String? ?? 'Unknown',
        score: map['total_points'] as int? ?? 0,
        isCrowned: (map['rank'] as int?) == 1,
        storyUserId: map['id']?.toString(),
        avatar: map['avatar'] as String?,
      );
    }).toList();

    // Convert rankings (fallback to top_3 if empty)
    List<RankEntry> entries = rankingsRaw.map((item) {
      final map = item as Map<String, dynamic>;
      return RankEntry(
        rank: map['rank'] as int? ?? 0,
        name: map['full_name'] as String? ?? 'Unknown',
        level: map['level'] as int? ?? 1,
        score: map['total_points'] as int? ?? 0,
        isCurrentUser: false,
        storyUserId: map['id']?.toString(),
        avatar: map['avatar'] as String?,
      );
    }).toList();

    if (entries.isEmpty && podium.isNotEmpty) {
      entries = podium.map((p) => RankEntry(
            rank: p.rank,
            name: p.name,
            level: 1,
            score: p.score,
            isCurrentUser: false,
            storyUserId: p.storyUserId,
            avatar: p.avatar,
          )).toList();
    }

    // Current user
    RankEntry? currentUser;
    if (currentRaw != null) {
      currentUser = RankEntry(
        rank: currentRaw['rank'] as int? ?? 0,
        name: currentRaw['full_name'] as String? ?? 'You',
        level: currentRaw['level'] as int? ?? 1,
        score: currentRaw['total_points'] as int? ?? 0,
        isCurrentUser: true,
        storyUserId: currentRaw['id']?.toString(),
        avatar: currentRaw['avatar'] as String?,
      );
    }

    return RankModel(
      selectedScope: scope,
      selectedPeriod: period,
      podium: podium,
      entries: entries,
      currentUser: currentUser,
    );
  }

  String _scopeToString(RankScope scope) {
    switch (scope) {
      case RankScope.city:
        return 'city';
      case RankScope.country:
        return 'country';
      case RankScope.global:
        return 'global';
      case RankScope.followers:
        return 'followers';
    }
  }

  String _periodToString(RankPeriod period) {
    switch (period) {
      case RankPeriod.weekly:
        return 'weekly';
      case RankPeriod.monthly:
        return 'monthly';
      case RankPeriod.allTime:
        return 'all_time';
    }
  }
}