import 'package:locals/l10n/app_localizations.dart';

class NotificationL10n {
  NotificationL10n._();

  static String title(AppLocalizations l10n, String id) {
    return switch (id) {
      'missions' => l10n.notificationMissionAlerts,
      'events' => l10n.notificationEvents,
      'announcements' => l10n.notificationAnnouncements,
      _ => id,
    };
  }

  static String subtitle(AppLocalizations l10n, String id) {
    return switch (id) {
      'missions' => l10n.notificationMissionAlertsDesc,
      'events' => l10n.notificationEventsDesc,
      'announcements' => l10n.notificationAnnouncementsDesc,
      _ => '',
    };
  }
}
