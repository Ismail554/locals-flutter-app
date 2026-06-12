import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class LoginSignupFooter extends StatelessWidget {
  final VoidCallback onCreateAccount;

  const LoginSignupFooter({super.key, required this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New here? ',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: onCreateAccount,
          child: Text(
            'Create account',
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
