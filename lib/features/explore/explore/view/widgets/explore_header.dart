import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/locals_logo.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ExploreHeader extends StatelessWidget {
  final VoidCallback onNotificationTap;

  const ExploreHeader({super.key, required this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LocalsLogo.black(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onNotificationTap,
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: AppColors.chipUnselected,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                color: AppColors.black,
                size: 22.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
