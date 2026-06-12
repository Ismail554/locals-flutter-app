import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MissionDetailsBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const MissionDetailsBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          width: 44.w,
          height: 44.w,
          decoration: const BoxDecoration(
            color: AppColors.chipUnselected,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.chevron_left,
            color: AppColors.black,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
