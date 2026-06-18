import 'package:locals/features/profile/privacy/model/privacy_model.dart';
import 'package:locals/l10n/app_localizations.dart';

class PrivacyL10n {
  PrivacyL10n._();

  static String sectionLabel(
    AppLocalizations l10n,
    PrivacySetting<dynamic> setting,
  ) {
    if (setting.value is ProfileVisibility) {
      return l10n.privacySectionProfileVisibility;
    }
    if (setting.value is PhotoVisibility) {
      return l10n.privacySectionPhotoVisibility;
    }
    if (setting.value is LocationPermission) {
      return l10n.privacySectionLocationPermission;
    }
    return l10n.privacySectionLeaderboard;
  }

  static String optionLabel(AppLocalizations l10n, String id) {
    return switch (id) {
      'public' => l10n.privacyPublic,
      'private' => l10n.privacyPrivate,
      'followers_only' => l10n.privacyFollowersOnly,
      'all_time' => l10n.privacyAllTime,
      'while_using' => l10n.privacyWhileUsingApp,
      'on' => l10n.privacyOn,
      'off' => l10n.privacyOff,
      _ => id,
    };
  }
}
