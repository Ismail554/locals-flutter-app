import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ExploreSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const ExploreSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.levelGrey),
        SizedBox(width: 6.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.levelGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        if (actionLabel != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: TextStyle(
                color: AppColors.actionPink,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
