import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final Widget? trailing;

  const ProfileScreenHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
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
          Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (trailing != null)
            Align(alignment: Alignment.centerRight, child: trailing!),
        ],
      ),
    );
  }
}
