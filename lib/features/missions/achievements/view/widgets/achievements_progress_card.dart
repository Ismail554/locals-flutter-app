import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class AchievementsProgressCard extends StatelessWidget {
  final int unlockedCount;
  final int totalCount;

  const AchievementsProgressCard({
    super.key,
    required this.unlockedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFC23651), Color(0xFFE53935)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UNLOCKED',
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.85),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$unlockedCount',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              Text(
                '/$totalCount',
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.55),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            'Keep visiting to unlock more.',
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.85),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
