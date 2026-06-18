import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ProfileLevelCard extends StatelessWidget {
  final int level;
  final int points;
  final String levelTitle;
  final int pointsToNextLevel;

  const ProfileLevelCard({
    super.key,
    required this.level,
    required this.points,
    required this.levelTitle,
    required this.pointsToNextLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.profileLevelCard,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level $level',
                style: TextStyle(color: AppColors.white, fontSize: 13.sp),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$points',
                    style: TextStyle(
                      color: AppColors.actionPink,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    context.l10n.statPoints,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.7),
                      fontSize: 10.sp,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            levelTitle,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 6.h,
              backgroundColor: AppColors.white.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation(AppColors.actionPink),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '$pointsToNextLevel Pts To Level ${level + 1}',
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.6),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
