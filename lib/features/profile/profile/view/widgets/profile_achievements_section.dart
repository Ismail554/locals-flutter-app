import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/profile_model.dart';

class ProfileAchievementsSection extends StatelessWidget {
  final List<ProfileAchievement> achievements;

  const ProfileAchievementsSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent achievements',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'View all',
              style: TextStyle(
                color: AppColors.actionPink,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final item = achievements[index];
              return Container(
                width: 90.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, color: item.color, size: 28.sp),
                    SizedBox(height: 8.h),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
