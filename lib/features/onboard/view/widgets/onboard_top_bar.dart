import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/locals_logo.dart';
import 'package:locals/shared/theme/app_colors.dart';

class OnboardTopBar extends StatelessWidget {
  final bool showSkip;
  final VoidCallback onSkip;

  const OnboardTopBar({
    super.key,
    required this.showSkip,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const LocalsLogo(),
        if (showSkip)
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                color: AppColors.onboardGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.45,
                letterSpacing: 0.96,
              ),
            ),
          )
        else
          SizedBox(width: 48.w),
      ],
    );
  }
}
