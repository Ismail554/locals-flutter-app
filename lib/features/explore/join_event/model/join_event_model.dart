import 'package:flutter/material.dart';

class JoinEventRouteStop {
  final int number;
  final String name;
  final String category;
  final Color thumbnailColor;
  final String? locationId;
  final String? imageUrl;

  const JoinEventRouteStop({
    required this.number,
    required this.name,
    required this.category,
    required this.thumbnailColor,
    this.locationId,
    this.imageUrl,
  });

  factory JoinEventRouteStop.fromApi(Map<String, dynamic> json) {
    final place = json['place'] as Map<String, dynamic>? ?? {};
    final categoryJson = place['category'] as Map<String, dynamic>?;

    return JoinEventRouteStop(
      number: json['order'] as int? ?? 0,
      name: place['name'] as String? ?? '',
      category: categoryJson?['name'] as String? ?? '',
      thumbnailColor: const Color(0xFFD4C4B0),
      locationId: place['id']?.toString(),
      imageUrl: place['cover_photo'] as String?,
    );
  }
}

class JoinEventModel {
  final String id;
  final String sponsor;
  final String title;
  final String dateLabel;
  final Color heroColor;
  final String? heroImageUrl;
  final int totalStops;
  final int rewardPoints;
  final int progressCurrent;
  final List<JoinEventRouteStop> stops;
  final bool isJoined;

  const JoinEventModel({
    required this.id,
    required this.sponsor,
    required this.title,
    required this.dateLabel,
    required this.heroColor,
    this.heroImageUrl,
    required this.totalStops,
    required this.rewardPoints,
    required this.progressCurrent,
    required this.stops,
    this.isJoined = false,
  });

  String get progressLabel => '$progressCurrent/$totalStops';

  JoinEventModel copyWith({bool? isJoined, int? progressCurrent}) {
    return JoinEventModel(
      id: id,
      sponsor: sponsor,
      title: title,
      dateLabel: dateLabel,
      heroColor: heroColor,
      heroImageUrl: heroImageUrl,
      totalStops: totalStops,
      rewardPoints: rewardPoints,
      progressCurrent: progressCurrent ?? this.progressCurrent,
      stops: stops,
      isJoined: isJoined ?? this.isJoined,
    );
  }

  factory JoinEventModel.fromApi(Map<String, dynamic> json) {
    final startDate = json['start_date'] as String?;
    final endDate = json['end_date'] as String?;

    String dateLabel = 'ONGOING';
    if (startDate != null && endDate != null) {
      dateLabel =
          '${_monthLabel(startDate)} – ${_monthLabel(endDate)}';
    } else if (startDate != null) {
      dateLabel = _monthLabel(startDate);
    }

    final stopsRaw = json['stops'] as List? ?? [];
    final stops = stopsRaw
        .map((s) =>
            JoinEventRouteStop.fromApi(s as Map<String, dynamic>))
        .toList();

    // Parse progress "0/6" → current = 0
    final progressStr = json['user_progress'] as String? ?? '0/0';
    final progressParts = progressStr.split('/');
    final progressCurrent =
        int.tryParse(progressParts.first) ?? 0;

    return JoinEventModel(
      id: json['id'].toString(),
      sponsor: json['organizer'] as String? ?? '',
      title: json['title'] as String? ?? '',
      dateLabel: dateLabel,
      heroColor: const Color(0xFF4A6A8A),
      heroImageUrl: json['cover_photo'] as String?,
      totalStops: json['total_stops'] as int? ?? stops.length,
      rewardPoints: json['reward_points'] as int? ?? 0,
      progressCurrent: progressCurrent,
      stops: stops,
    );
  }

  static String _monthLabel(String isoDate) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];
    try {
      final parts = isoDate.split('-');
      final month = months[int.parse(parts[1]) - 1];
      final day = parts[2];
      return '$month $day';
    } catch (_) {
      return isoDate;
    }
  }
}