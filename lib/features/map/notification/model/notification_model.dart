class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String emoji;
  final String timeAgo;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.emoji,
    required this.timeAgo,
    required this.isRead,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      emoji: _emojiFromType(json['notification_type']),
      timeAgo: _timeAgo(json['created_at']),
      isRead: json['is_read'] ?? false,
    );
  }

  NotificationItem copyWith({
    bool? isRead,
  }) {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      emoji: emoji,
      timeAgo: timeAgo,
      isRead: isRead ?? this.isRead,
    );
  }

  static String _emojiFromType(String? type) {
    switch (type) {
      case 'MISSION':
        return '🎯';
      case 'SYSTEM':
        return '📣';
      case 'CHECKIN':
        return '📍';
      case 'LEVEL_UP':
        return '⭐';
      default:
        return '🔔';
    }
  }

  static String _timeAgo(String? value) {
    if (value == null) return '';

    final date = DateTime.tryParse(value);

    if (date == null) return '';

    final diff = DateTime.now().difference(date.toLocal());

    if (diff.inMinutes < 1) {
      return 'Now';
    }

    if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    }

    if (diff.inDays < 1) {
      return '${diff.inHours}h';
    }

    if (diff.inDays < 30) {
      return '${diff.inDays}d';
    }

    if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()}mo';
    }

    return '${(diff.inDays / 365).floor()}y';
  }
}

class NotificationModel {
  final int count;
  final String? next;
  final String? previous;
  final List<NotificationItem> items;

  const NotificationModel({
    this.count = 0,
    this.next,
    this.previous,
    this.items = const [],
  });

  bool get hasUnread => items.any((e) => !e.isRead);

  bool get hasNextPage => next != null;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      items: (json['results'] as List<dynamic>? ?? [])
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
    );
  }

  NotificationModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<NotificationItem>? items,
  }) {
    return NotificationModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      items: items ?? this.items,
    );
  }
}