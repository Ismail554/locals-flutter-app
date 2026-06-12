import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join locals',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Start collecting authentic places.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
