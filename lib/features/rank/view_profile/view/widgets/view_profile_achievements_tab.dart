import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/view_profile_model.dart';

class ViewProfileAchievementsTab extends StatelessWidget {
  final List<ViewProfileAchievement> achievements;

  const ViewProfileAchievementsTab({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No achievements yet',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.05,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final item = achievements[index];
        final isUnlocked = item.isUnlocked;

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isUnlocked 
                ? AppColors.chipUnselected 
                : AppColors.chipUnselected.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16.r),
            border: isUnlocked 
                ? Border.all(color: AppColors.actionPink.withOpacity(0.4), width: 1.5)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: isUnlocked ? 1.0 : 0.45,
                child: Icon(
                  item.icon, 
                  color: item.color, 
                  size: 34.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isUnlocked ? AppColors.black : AppColors.textSecondary,
                  fontSize: 11.sp,
                  fontWeight: isUnlocked ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (isUnlocked && item.pointsAwarded > 0) ...[
                SizedBox(height: 4.h),
                Text(
                  '+${item.pointsAwarded}',
                  style: TextStyle(
                    color: AppColors.actionPink,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}