import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/locals_logo.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MissionsHeader extends StatelessWidget {
  final VoidCallback onAchievementsTap;

  const MissionsHeader({super.key, required this.onAchievementsTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const LocalsLogo(),
            TextButton.icon(
              onPressed: onAchievementsTap,
              icon: Icon(Icons.military_tech_outlined, color: AppColors.actionPink, size: 18.sp),
              label: Text(
                'Achievements',
                style: TextStyle(
                  color: AppColors.actionPink,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          'Missions',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Curated challenges to discover Barcelona.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
