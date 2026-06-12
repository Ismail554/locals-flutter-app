import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/set_notification_model.dart';

class NotificationSettingTile extends StatelessWidget {
  final NotificationSetting setting;
  final ValueChanged<bool> onChanged;

  const NotificationSettingTile({
    super.key,
    required this.setting,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.rankListItemBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  setting.title,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  setting.subtitle,
                  style: TextStyle(
                    color: AppColors.levelGrey,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: setting.enabled,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.actionPink,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.borderGray,
          ),
        ],
      ),
    );
  }
}
