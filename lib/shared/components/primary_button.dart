import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50.r),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          decoration: ShapeDecoration(
            color: AppColors.actionPink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                height: 1.44,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
