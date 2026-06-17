import 'package:flutter/material.dart';

enum SettingsSectionType { preferences, account, about, dangerZone }

class SettingsItem {
  final String id;
  final IconData icon;
  final String label;
  final String? trailingText;
  final bool isDanger;

  const SettingsItem({
    required this.id,
    required this.icon,
    required this.label,
    this.trailingText,
    this.isDanger = false,
  });
}

class SettingsSection {
  final String title;
  final SettingsSectionType type;
  final List<SettingsItem> items;

  const SettingsSection({
    required this.title,
    required this.type,
    required this.items,
  });
}

class SettingsModel {
  final String language;
  final List<SettingsSection> sections;

  const SettingsModel({
    this.language = 'English',
    this.sections = const [
      SettingsSection(
        title: 'PREFERENCES',
        type: SettingsSectionType.preferences,
        items: [
          SettingsItem(
            id: 'language',
            icon: Icons.language,
            label: 'Language',
            trailingText: 'English',
          ),
          SettingsItem(
            id: 'notification',
            icon: Icons.notifications_none,
            label: 'Notification',
          ),
          SettingsItem(
            id: 'privacy',
            icon: Icons.lock_outline,
            label: 'Privacy',
          ),
        ],
      ),
      SettingsSection(
        title: 'ACCOUNT',
        type: SettingsSectionType.account,
        items: [
          SettingsItem(
            id: 'edit_profile',
            icon: Icons.person_outline,
            label: 'Edit Profile',
          ),
          // SettingsItem(
          //   id: 'manage_subscription',
          //   icon: Icons.workspace_premium_outlined,
          //   label: 'Manage subscription',
          // ),
        ],
      ),
      SettingsSection(
        title: 'ABOUT',
        type: SettingsSectionType.about,
        items: [
          SettingsItem(
            id: 'help',
            icon: Icons.headset_mic_outlined,
            label: 'Help & Support',
          ),
          SettingsItem(
            id: 'policy',
            icon: Icons.description_outlined,
            label: 'Privacy and policy',
          ),
          SettingsItem(
            id: 'rate',
            icon: Icons.star_outline,
            label: 'Rate Local',
          ),
        ],
      ),
      SettingsSection(
        title: 'DANGER ZONE',
        type: SettingsSectionType.dangerZone,
        items: [
          SettingsItem(
            id: 'logout',
            icon: Icons.logout,
            label: 'Log out',
          ),
        ],
      ),
    ],
  });
}
