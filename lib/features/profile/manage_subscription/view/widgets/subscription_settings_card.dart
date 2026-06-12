import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SubscriptionSettingsCard extends StatelessWidget {
  final bool autoRenew;
  final ValueChanged<bool> onAutoRenewChanged;

  const SubscriptionSettingsCard({
    super.key,
    required this.autoRenew,
    required this.onAutoRenewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderGray.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto-renew',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Will renew automatically each month',
                        style: TextStyle(
                          color: AppColors.levelGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: autoRenew,
                  onChanged: onAutoRenewChanged,
                  activeThumbColor: AppColors.white,
                  activeTrackColor: AppColors.actionPink,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: AppColors.borderGray,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.borderGray.withValues(alpha: 0.5)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(Icons.workspace_premium_outlined,
                    color: AppColors.actionPink, size: 22.sp),
                SizedBox(width: 12.w),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upgrade to Yearly',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Save 50% · \$4.92/mo',
                        style: TextStyle(
                          color: AppColors.levelGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Switch',
                  style: TextStyle(
                    color: AppColors.actionPink,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.borderGray.withValues(alpha: 0.5)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'Cancel subscription',
              style: TextStyle(
                color: AppColors.actionPink,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
