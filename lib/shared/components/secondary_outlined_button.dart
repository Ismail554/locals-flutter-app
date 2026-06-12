import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SecondaryOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: NeumorphicButton(
        onPressed: onPressed,
        style: NeumorphicStyle(
          depth: 2,
          color: Colors.transparent,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(30.r),
          ),
          border: NeumorphicBorder(
            color: AppColors.white.withValues(alpha: 0.6),
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.zero,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
