import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'locals_logo.dart';

class AuthScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 0,
        color: AppColors.darkBackground,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.only(
            bottomLeft: Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24.w, 56.h, 24.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LocalsLogo(),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
