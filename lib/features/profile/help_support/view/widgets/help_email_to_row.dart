import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class HelpEmailToRow extends StatelessWidget {
  final String email;

  const HelpEmailToRow({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.helpEmailTo,
          style: TextStyle(
            color: AppColors.textSub2,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Icon(Icons.mail_outline, color: AppColors.actionPink, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                email,
                style: TextStyle(
                  color: AppColors.actionPink,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
