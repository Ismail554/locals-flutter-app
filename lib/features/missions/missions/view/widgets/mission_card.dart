import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/missions_model.dart';

class MissionCard extends StatelessWidget {
  final MissionItem mission;
  final VoidCallback onTap;

  const MissionCard({
    super.key,
    required this.mission,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: AppColors.chipSelected,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.adjust, color: AppColors.white, size: 20.sp),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+${mission.points}',
                        style: TextStyle(
                          color: AppColors.actionPink,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        mission.difficulty,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                mission.title,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                mission.description,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 14.sp, color: AppColors.textSecondary),
                  SizedBox(width: 4.w),
                  Text(
                    mission.distance,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                  ),
                  const Spacer(),
                  Text(
                    '${mission.currentProgress}/${mission.totalProgress}',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: mission.progress,
                  minHeight: 6.h,
                  backgroundColor: AppColors.chipUnselected,
                  valueColor: const AlwaysStoppedAnimation(AppColors.actionPink),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
