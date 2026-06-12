import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/settings_model.dart';

class SettingsTile extends StatelessWidget {
  final SettingsItem item;
  final VoidCallback onTap;
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.item,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = item.isDanger ? AppColors.actionPink : AppColors.black;
    final iconColor = item.isDanger ? AppColors.actionPink : AppColors.black;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Icon(item.icon, size: 20.sp, color: iconColor),
                  SizedBox(width: 12.w),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (item.trailingText != null) ...[
                    Text(
                      item.trailingText!,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Icon(
                    Icons.chevron_right,
                    size: 20.sp,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Divider(
              height: 1,
              color: AppColors.borderGray.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}
