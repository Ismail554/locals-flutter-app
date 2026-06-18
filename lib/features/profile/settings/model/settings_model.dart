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
