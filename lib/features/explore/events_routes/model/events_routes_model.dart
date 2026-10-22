import 'package:flutter/material.dart';

class EventRouteItem {
  final String id;
  final String dateLabel;
  final String title;
  final String organizer;
  final int points;
  final Color imageColor;
  final String? imageUrl;
  final String totalStops;
  final String userProgress;

  const EventRouteItem({
    required this.id,
    required this.dateLabel,
    required this.title,
    required this.organizer,
    required this.points,
    required this.imageColor,
    this.imageUrl,
    this.totalStops = '0',
    this.userProgress = '0/0',
  });

  factory EventRouteItem.fromApi(Map<String, dynamic> json) {
    final startDate = json['start_date'] as String?;
    final endDate = json['end_date'] as String?;

    String dateLabel = 'ONGOING';
    if (startDate != null && endDate != null) {
      // "2026-07-04" → "JUL 04"
      dateLabel =
          '${_monthLabel(startDate)} – ${_monthLabel(endDate)}';
    } else if (startDate != null) {
      dateLabel = _monthLabel(startDate);
    }

    return EventRouteItem(
      id: json['id'].toString(),
      dateLabel: dateLabel,
      title: json['title'] as String? ?? '',
      organizer: json['organizer'] as String? ?? '',
      points: json['reward_points'] as int? ?? 0,
      imageColor: const Color(0xFF4A6A8A),
      imageUrl: json['cover_photo'] as String?,
      totalStops: (json['total_stops'] ?? 0).toString(),
      userProgress: json['user_progress'] as String? ?? '0/0',
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

class EventsRoutesModel {
  final List<EventRouteItem> events;
  final bool isLoading;
  final String? errorMessage;

  const EventsRoutesModel({
    this.events = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  EventsRoutesModel copyWith({
    List<EventRouteItem>? events,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return EventsRoutesModel(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}