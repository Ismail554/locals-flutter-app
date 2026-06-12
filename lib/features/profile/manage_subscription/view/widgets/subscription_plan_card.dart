import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final String planName;
  final String renewalText;
  final String price;

  const SubscriptionPlanCard({
    super.key,
    required this.planName,
    required this.renewalText,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEA4D70), Color(0xFFD63A5C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium, color: AppColors.white, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'Current plan',
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.9),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            planName,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '$renewalText · $price',
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.9),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppColors.white, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'All premium features unlocked',
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.95),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
