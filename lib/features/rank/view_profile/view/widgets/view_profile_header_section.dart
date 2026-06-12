import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ViewProfileHeaderSection extends StatelessWidget {
  final String name;
  final int level;
  final String location;
  final bool hasStory;

  const ViewProfileHeaderSection({
    super.key,
    required this.name,
    required this.level,
    required this.location,
    required this.hasStory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96.w,
          height: 96.w,
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: hasStory
                ? const LinearGradient(
                    colors: [Color(0xFFEA4D70), Color(0xFFFF8FA3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            border: hasStory
                ? null
                : Border.all(color: AppColors.borderGray, width: 2),
            color: hasStory ? null : AppColors.chipUnselected,
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.chipUnselected,
            child: Icon(
              Icons.person,
              color: AppColors.textSecondary,
              size: 44.sp,
            ),
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
          'Level $level · $location',
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
