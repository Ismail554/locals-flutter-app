import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class StoryReactionBar extends StatelessWidget {
  final bool isLiked;
  final int likeCount;
  final bool showHeartBurst;
  final VoidCallback onHeartTap;

  const StoryReactionBar({
    super.key,
    required this.isLiked,
    required this.likeCount,
    required this.showHeartBurst,
    required this.onHeartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onHeartTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isLiked
                    ? AppColors.actionPink.withValues(alpha: 0.25)
                    : AppColors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? AppColors.actionPink : AppColors.white,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '$likeCount',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
