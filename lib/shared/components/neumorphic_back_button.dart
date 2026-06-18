import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class NeumorphicBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NeumorphicBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        depth: 4,
        intensity: 0.7,
        color: AppColors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios_new, size: 16.sp, color: AppColors.black),
          SizedBox(width: 4.w),
          Text(
            context.l10n.commonBack,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
