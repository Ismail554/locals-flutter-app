import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ViewProfileActionButtons extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onFollowTap;
  final bool isPhotosActive;
  final VoidCallback onSecondaryButtonTap;

  const ViewProfileActionButtons({
    super.key,
    required this.isFollowing,
    required this.onFollowTap,
    required this.isPhotosActive,
    required this.onSecondaryButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Follow / Following Button
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: TextButton(
              onPressed: onFollowTap,
              style: TextButton.styleFrom(
                backgroundColor: isFollowing
                    ? AppColors.actionPink.withValues(alpha: 0.1)
                    : AppColors.actionPink,
                foregroundColor: isFollowing ? AppColors.actionPink : AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
              ),
              child: Text(
                isFollowing ? context.l10n.commonFollowing : context.l10n.commonFollow,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),

        // Toggle Button: Photos <-> Profile Details
        // Toggle Button: Photos <-> Profile Details
Expanded(
  child: SizedBox(
    height: 48.h,
    child: TextButton(
      onPressed: onSecondaryButtonTap,
      style: TextButton.styleFrom(
        backgroundColor: isPhotosActive
            ? AppColors.chipUnselected
            : AppColors.actionPink.withValues(alpha: 0.1),

        foregroundColor: isPhotosActive
            ? AppColors.black
            : AppColors.actionPink,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
          side: BorderSide(
            color: isPhotosActive
                ? Colors.transparent
                : AppColors.actionPink,
            width: 1.5,
          ),
        ),
      ),
      child: Text(
        isPhotosActive
            ? context.l10n.profileDetails
            : context.l10n.viewProfileTabPhotos,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
),
      ],
    );
  }
}