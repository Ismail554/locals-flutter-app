import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String location;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.actionPink, width: 3),
          ),
          child: CircleAvatar(
            radius: 48.r,
            backgroundColor: AppColors.chipUnselected,
            child: Icon(Icons.person, size: 48.sp, color: AppColors.textSecondary),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          name,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          location,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
