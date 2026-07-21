import 'package:flutter/material.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';

class ProfileAchievement {
  final String label;
  final IconData icon;
  final Color color;

  const ProfileAchievement({
    required this.label,
    required this.icon,
    required this.color,
  });

  factory ProfileAchievement.fromApi(Map<String, dynamic> json) {
    final achievement = json['achievement'] as Map<String, dynamic>? ?? {};
    final ruleCode = achievement['rule_code'] as String? ?? '';
    final style = _iconForRuleCode(ruleCode);
    return ProfileAchievement(
      label: achievement['title'] as String? ?? '',
      icon: style.$1,
      color: style.$2,
    );
  }

  // Extend this as new rule_codes appear on the backend.
  static (IconData, Color) _iconForRuleCode(String ruleCode) {
    switch (ruleCode) {
      case 'FIRST_CHECKIN':
        return (Icons.eco_outlined, const Color(0xFF4CD964));
      case 'NIGHT_OWL':
        return (Icons.nightlight_outlined, const Color(0xFFFFB800));
      case 'TEN_VISITS':
        return (Icons.location_on_outlined, const Color(0xFFEA4D70));
      case 'CAFE_CONNOISSEUR':
        return (Icons.coffee_outlined, const Color(0xFF8B6914));
      default:
        return (Icons.emoji_events_outlined, const Color(0xFFB8860B));
    }
  }
}

class ProfileVisitTile extends CheckInPhoto {
  const ProfileVisitTile({
    required super.previewColor,
    required super.locationName,
    required super.timeAgo,
    required super.caption,
    required super.likes,
  });

  static const _palette = [
    Color(0xFFD4A574),
    Color(0xFF7EB8DA),
    Color(0xFFE8A0A0),
    Color(0xFF9BB5CE),
    Color(0xFFC4B5A0),
    Color(0xFF8FA89A),
  ];

  factory ProfileVisitTile.fromApi(Map<String, dynamic> json, int index) {
    return ProfileVisitTile(
      previewColor: _palette[index % _palette.length],
      locationName: 'Place #${json['place']}',
      timeAgo: _timeAgo(json['created_at'] as String?),
      caption: (json['caption'] as String?) ?? '',
      likes: (json['likes_count'] as int?) ?? 0,
    );
  }

  static String _timeAgo(String? isoDate) {
    if (isoDate == null) return '';
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    final diff = DateTime.now().toUtc().difference(date.toUtc());
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    return '${(diff.inDays / 30).floor()}mo ago';
  }
}

class ProfileModel {
  final String name;
  final String location;
  final int level;
  final int points;
  final String levelTitle;
  final int pointsToNextLevel;
  final int visitCount;
  final int cities;
  final int followers;
  final List<ProfileAchievement> achievements;
  final List<ProfileVisitTile> latestVisits;

  const ProfileModel({
    this.name = '',
    this.location = '',
    this.level = 0,
    this.points = 0,
    this.levelTitle = '',
    this.pointsToNextLevel = 0,
    this.visitCount = 0,
    this.cities = 0,
    this.followers = 0,
    this.achievements = const [],
    this.latestVisits = const [],
  });

  factory ProfileModel.fromApi({
    required Map<String, dynamic> profileJson,
    required List<dynamic> achievementsJson,
    required List<dynamic> checkinsJson,
  }) {
    final level = (profileJson['level'] as int?) ?? 0;
    final points = (profileJson['total_points'] as int?) ??
        (profileJson['points_count'] as int?) ??
        0;

    return ProfileModel(
      name: (profileJson['full_name'] as String?) ?? '',
      location: (profileJson['location_city'] as String?) ?? '',
      level: level,
      points: points,
      levelTitle: _levelTitle(level),
      pointsToNextLevel: _pointsToNextLevel(level, points),
      visitCount: (profileJson['visits_count'] as int?) ?? 0,
      cities: (profileJson['cities_count'] as int?) ?? 0,
      followers: (profileJson['followers_count'] as int?) ?? 0,
      achievements: achievementsJson
          .map((e) => ProfileAchievement.fromApi(e as Map<String, dynamic>))
          .toList(),
      latestVisits: checkinsJson
          .asMap()
          .entries
          .map((e) =>
              ProfileVisitTile.fromApi(e.value as Map<String, dynamic>, e.key))
          .toList(),
    );
  }

  // The API doesn't currently return a level title or "points to next
  // level" — derived locally until the backend exposes real values.
  static String _levelTitle(int level) {
    const titles = [
      'Newcomer',
      'Explorer',
      'Wanderer',
      'Regular',
      'Local Insider',
      'Neighborhood Scout',
    ];
    return titles[(level - 1).clamp(0, titles.length - 1)];
  }

  static int _pointsToNextLevel(int level, int points) {
    const perLevel = 500;
    final remaining = (level * perLevel) - points;
    return remaining > 0 ? remaining : 0;
  }

  String get shareUrl =>
      'https://local.app/p/${name.toLowerCase().replaceAll(' ', '')}';
}