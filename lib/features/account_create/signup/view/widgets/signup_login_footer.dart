import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SignupLoginFooter extends StatelessWidget {
  final VoidCallback onLogin;

  const SignupLoginFooter({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already a local? ',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: onLogin,
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
