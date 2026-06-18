import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class VerifyOtpResendRow extends StatelessWidget {
  final VoidCallback onResend;

  const VerifyOtpResendRow({super.key, required this.onResend});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${context.l10n.otpDidntReceiveCode} ',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: onResend,
          child: Text(
            context.l10n.otpResend,
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
