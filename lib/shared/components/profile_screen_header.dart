import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback? onMorePressed;   // 3-dot menu
  final Widget? trailing;              // Kept for future flexibility

  const ProfileScreenHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.onMorePressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back Button - Left
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onBack,
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
            ),
          ),

          // Title - Center
          Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          // Right Side (3-dot or custom trailing)
          Align(
            alignment: Alignment.centerRight,
            child: trailing ?? 
              (onMorePressed != null 
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onMorePressed,
                      borderRadius: BorderRadius.circular(22.r),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: const BoxDecoration(
                          // color: AppColors.chipUnselected,
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.more_horiz,
                          color: AppColors.black,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: 44)),
          ),
        ],
      ),
    );
  }
}