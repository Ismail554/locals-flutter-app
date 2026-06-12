import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -2,
            intensity: 0.6,
            color: AppColors.inputBackground,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.r)),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 14.sp, color: AppColors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary, size: 20.sp),
              suffixIcon: suffix,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }
}
