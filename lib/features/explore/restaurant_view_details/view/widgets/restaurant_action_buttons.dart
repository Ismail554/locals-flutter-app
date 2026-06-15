import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantActionButtons extends StatelessWidget {
  final bool hasVisited;
  final VoidCallback onBeenHereTap;
  final VoidCallback onDirectionsTap;

  const RestaurantActionButtons({
    super.key,
    required this.hasVisited,
    required this.onBeenHereTap,
    required this.onDirectionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: OutlinedButton(
            onPressed: onBeenHereTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.actionPink,
              side: const BorderSide(color: AppColors.actionPink, width: 1.5),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.r),
              ),
            ),
            child: Text(
              hasVisited ? "I've been here ✓" : "I've been here",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FilledButton.icon(
            onPressed: onDirectionsTap,
            icon: Icon(Icons.near_me_outlined, size: 18.sp),
            label: Text(
              'Directions',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.actionPink,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
