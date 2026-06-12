import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';

class PrivacySettingRow extends StatelessWidget {
  final String label;
  final List<ProfileSegmentOption> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const PrivacySettingRow({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 10.h),
        ProfileSegmentedControl(
          options: options,
          selectedValue: selectedValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
