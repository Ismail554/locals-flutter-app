import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class VerifyOtpHintText extends StatelessWidget {
  const VerifyOtpHintText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'We have sent a 6-digit code to your email',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13.sp,
      ),
    );
  }
}
