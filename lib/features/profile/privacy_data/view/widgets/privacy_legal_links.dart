import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class PrivacyLegalLinks extends StatelessWidget {
  final VoidCallback onPrivacyPolicy;
  final VoidCallback onTermsOfUse;

  const PrivacyLegalLinks({
    super.key,
    required this.onPrivacyPolicy,
    required this.onTermsOfUse,
  });

  @override
  Widget build(BuildContext context) {
    final linkStyle = TextStyle(
      color: AppColors.black,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPrivacyPolicy,
          child: Text('Privacy policy', style: linkStyle),
        ),
        SizedBox(width: 32.w),
        GestureDetector(
          onTap: onTermsOfUse,
          child: Text('Terms of use', style: linkStyle),
        ),
      ],
    );
  }
}
