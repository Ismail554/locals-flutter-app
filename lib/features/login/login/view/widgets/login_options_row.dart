import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class LoginOptionsRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotPassword;

  const LoginOptionsRow({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              SizedBox(
                width: 22.w,
                height: 22.w,
                child: Checkbox(
                  value: rememberMe,
                  onChanged: onRememberChanged,
                  activeColor: AppColors.primaryPink,
                  side: BorderSide(color: AppColors.primaryPink, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Remember me',
                style: TextStyle(fontSize: 13.sp, color: AppColors.black),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onForgotPassword,
          child: Text(
            'Forgot password?',
            style: TextStyle(
              color: AppColors.primaryPink,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
