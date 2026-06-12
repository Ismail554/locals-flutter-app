import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/map_mission_args.dart';

class MapMissionProgressCard extends StatelessWidget {
  final MapActiveMission mission;

  const MapMissionProgressCard({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 12.h),
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
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.actionPink,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPLORING',
                      style: TextStyle(
                        color: AppColors.levelGrey,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      mission.city,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'COMPLETION',
                    style: TextStyle(
                      color: AppColors.levelGrey,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '${mission.completedCount}/${mission.totalCount} · ${mission.percent}%',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(3.r),
            child: LinearProgressIndicator(
              value: mission.progress,
              minHeight: 4.h,
              backgroundColor: AppColors.chipUnselected,
              valueColor: const AlwaysStoppedAnimation(AppColors.actionPink),
            ),
          ),
        ],
      ),
    );
  }
}
