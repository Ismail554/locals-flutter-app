class NotificationSetting {
  final String id;
  final String title;
  final String subtitle;
  final bool enabled;

  const NotificationSetting({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.enabled,
  });

  NotificationSetting copyWith({bool? enabled}) {
    return NotificationSetting(
      id: id,
      title: title,
      subtitle: subtitle,
      enabled: enabled ?? this.enabled,
    );
  }
}

class SetNotificationModel {
  final List<NotificationSetting> settings;

  const SetNotificationModel({
    this.settings = const [
      NotificationSetting(
        id: 'missions',
        title: 'Mission alerts',
        subtitle: 'When a new mission is available.',
        enabled: true,
      ),
      NotificationSetting(
        id: 'events',
        title: 'Events',
        subtitle: 'Festivals and sponsored routes.',
        enabled: true,
      ),
      NotificationSetting(
        id: 'announcements',
        title: 'Announcements',
        subtitle: 'Festivals and sponsored routes.',
        enabled: false,
      ),
    ],
  });

  SetNotificationModel copyWith({List<NotificationSetting>? settings}) {
    return SetNotificationModel(settings: settings ?? this.settings);
  }
}
