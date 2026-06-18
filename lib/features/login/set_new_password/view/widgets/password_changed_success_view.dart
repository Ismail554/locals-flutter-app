import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class PasswordChangedSuccessView extends StatelessWidget {
  const PasswordChangedSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.darkBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPink.withValues(alpha: 0.4),
                  blurRadius: 30.r,
                  spreadRadius: 4.r,
                ),
              ],
            ),
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: 8,
                color: AppColors.primaryPink,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: SizedBox(
                width: 120.w,
                height: 120.w,
                child: Icon(Icons.check, color: AppColors.white, size: 56.sp),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            context.l10n.setPasswordSuccessTitle,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            context.l10n.setPasswordSuccessMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryPink,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
