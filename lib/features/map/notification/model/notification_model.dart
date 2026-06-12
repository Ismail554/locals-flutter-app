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
    this.isRead = false,
  });

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      emoji: emoji,
      timeAgo: timeAgo,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationModel {
  final List<NotificationItem> items;

  const NotificationModel({
    this.items = const [
      NotificationItem(
        id: '1',
        title: 'Mission completed',
        message: 'You finished Coffee Cartographer and earned +250 pts.',
        emoji: '🎯',
        timeAgo: '2h',
      ),
      NotificationItem(
        id: '2',
        title: 'Level up!',
        message: "Congrats! You're now Level 15.",
        emoji: '⭐',
        timeAgo: '5h',
      ),
      NotificationItem(
        id: '3',
        title: 'New place nearby',
        message: 'Café del Born is 0.3 km away.',
        emoji: '📍',
        timeAgo: '1d',
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        title: 'Check-in reminder',
        message: "You haven't logged a visit in 3 days.",
        emoji: '🆕',
        timeAgo: '1d',
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        title: 'Weekend routes',
        message: 'New themed routes available in Gràcia.',
        emoji: '📣',
        timeAgo: '2d',
        isRead: true,
      ),
    ],
  });

  bool get hasUnread => items.any((item) => !item.isRead);

  NotificationModel copyWith({List<NotificationItem>? items}) {
    return NotificationModel(items: items ?? this.items);
  }
}
