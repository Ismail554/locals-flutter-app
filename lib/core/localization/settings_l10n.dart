import 'package:flutter/material.dart';
import 'package:locals/l10n/app_localizations.dart';
import 'package:locals/features/profile/settings/model/settings_model.dart';

class SettingsL10n {
  SettingsL10n._();

  static List<SettingsSection> buildSections(
    AppLocalizations l10n,
    String languageDisplayName,
  ) {
    return [
      SettingsSection(
        title: l10n.settingsSectionPreferences,
        type: SettingsSectionType.preferences,
        items: [
          SettingsItem(
            id: 'language',
            icon: Icons.language,
            label: l10n.settingsLanguage,
            trailingText: languageDisplayName,
          ),
          SettingsItem(
            id: 'notification',
            icon: Icons.notifications_none,
            label: l10n.settingsNotification,
          ),
          SettingsItem(
            id: 'privacy',
            icon: Icons.lock_outline,
            label: l10n.settingsPrivacy,
          ),
          SettingsItem(
            id: 'discount',
            icon: Icons.local_offer,
            label: l10n.settingsDiscounts,
          ),
        ],
      ),
      SettingsSection(
        title: l10n.settingsSectionAccount,
        type: SettingsSectionType.account,
        items: [
          SettingsItem(
            id: 'edit_profile',
            icon: Icons.person_outline,
            label: l10n.settingsEditProfile,
          ),
        ],
      ),
      SettingsSection(
        title: l10n.settingsSectionAbout,
        type: SettingsSectionType.about,
        items: [
          SettingsItem(
            id: 'help',
            icon: Icons.headset_mic_outlined,
            label: l10n.settingsHelpSupport,
          ),
          SettingsItem(
            id: 'policy',
            icon: Icons.description_outlined,
            label: l10n.settingsPrivacyPolicy,
          ),
          // SettingsItem(
          //   id: 'rate',
          //   icon: Icons.star_outline,
          //   label: l10n.settingsRateLocal,
          // ),
        ],
      ),
      SettingsSection(
        title: l10n.settingsSectionDangerZone,
        type: SettingsSectionType.dangerZone,
        items: [
          SettingsItem(
            id: 'logout',
            icon: Icons.logout,
            label: l10n.settingsLogOut,
            isDanger: true,
          ),
        ],
      ),
    ];
  }
}
