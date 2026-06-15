import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class HelpEmailField extends StatelessWidget {
  final String label;
  final String value;
  final TextEditingController? controller;
  final int maxLines;
  final bool readOnly;
  final String? hint;

  const HelpEmailField({
    super.key,
    required this.label,
    this.value = '',
    this.controller,
    this.maxLines = 1,
    this.readOnly = false,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSub2,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: readOnly
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textSub2,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : TextField(
                  controller: controller,
                  maxLines: maxLines,
                  style: TextStyle(
                    color: AppColors.actionPink,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: maxLines > 1 ? 16.h : 16.h,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
