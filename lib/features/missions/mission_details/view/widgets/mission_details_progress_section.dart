import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MissionDetailsProgressSection extends StatelessWidget {
  final int current;
  final int total;
  final double progress;

  const MissionDetailsProgressSection({
    super.key,
    required this.current,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'PROGRESS',
              style: TextStyle(
                color: AppColors.levelGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const Spacer(),
            Text(
              '$current/$total',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6.h,
            backgroundColor: AppColors.chipUnselected,
            valueColor: const AlwaysStoppedAnimation(AppColors.actionPink),
          ),
        ),
      ],
    );
  }
}
