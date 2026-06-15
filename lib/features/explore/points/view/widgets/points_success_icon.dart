import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class PointsSuccessIcon extends StatelessWidget {
  const PointsSuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.actionPink,
        boxShadow: [
          BoxShadow(
            color: AppColors.actionPink.withValues(alpha: 0.35),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Icon(
        Icons.check_rounded,
        color: AppColors.white,
        size: 56.sp,
      ),
    );
  }
}
