import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MapCircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool showBadge;

  const MapCircleActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: 22.sp, color: AppColors.black),
              if (showBadge)
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: AppColors.actionPink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
