import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/settings_model.dart';
import 'settings_tile.dart';

class SettingsSectionCard extends StatelessWidget {
  final SettingsSection section;
  final ValueChanged<String> onItemTap;

  const SettingsSectionCard({
    super.key,
    required this.section,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.rankListItemBg,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              for (var i = 0; i < section.items.length; i++)
                SettingsTile(
                  item: section.items[i],
                  onTap: () => onItemTap(section.items[i].id),
                  showDivider: i < section.items.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
