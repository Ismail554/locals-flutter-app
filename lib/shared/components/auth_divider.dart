import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Divider(color: AppColors.borderGray, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'or continue with',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
          ),
        ),
        Flexible(
          flex: 1,
          child: Divider(color: AppColors.borderGray, thickness: 1),
        ),
      ],
    );
  }
}
