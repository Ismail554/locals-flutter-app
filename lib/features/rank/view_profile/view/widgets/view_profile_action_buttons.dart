import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ViewProfileActionButtons extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onFollowTap;
  final VoidCallback onBlockTap;

  const ViewProfileActionButtons({
    super.key,
    required this.isFollowing,
    required this.onFollowTap,
    required this.onBlockTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox(
            height: 48.h,
            child: TextButton(
              onPressed: onFollowTap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.actionPink,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                shadowColor: AppColors.actionPink.withValues(alpha: 0.35),
                elevation: 4,
              ),
              child: Text(
                isFollowing ? context.l10n.commonFollowing : context.l10n.commonFollow,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox(
            height: 48.h,
            child: TextButton(
              onPressed: onBlockTap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.chipUnselected,
                foregroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                context.l10n.commonBlock,
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
