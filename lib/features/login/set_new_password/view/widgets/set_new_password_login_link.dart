import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SetNewPasswordLoginLink extends StatelessWidget {
  final VoidCallback onTap;

  const SetNewPasswordLoginLink({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Back to ',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Log in',
            style: TextStyle(
              color: AppColors.primaryPink,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
