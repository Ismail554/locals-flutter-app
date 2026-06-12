import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/achievements_model.dart';

class AchievementGridCard extends StatelessWidget {
  final AchievementItem achievement;

  const AchievementGridCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isUnlocked = achievement.isUnlocked;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            achievement.emoji,
            style: TextStyle(fontSize: 28.sp, height: 1),
          ),
          SizedBox(height: 8.h),
          Text(
            achievement.title,
            style: TextStyle(
              color: isUnlocked ? AppColors.black : const Color(0xFFBDBDBD),
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            achievement.subtitle,
            style: TextStyle(
              color: isUnlocked ? AppColors.levelGrey : const Color(0xFFBDBDBD),
              fontSize: 12.sp,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
