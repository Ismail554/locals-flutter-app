import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class EmailVerifiedSuccessView extends StatelessWidget {
  const EmailVerifiedSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.darkBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: const BoxDecoration(
              color: AppColors.actionPink,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: AppColors.white,
              size: 56.sp,
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            'Email Verified',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'Your email has been verified successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.actionPink,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
