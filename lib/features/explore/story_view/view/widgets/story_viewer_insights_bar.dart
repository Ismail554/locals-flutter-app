import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class StoryViewerInsightsBar extends StatelessWidget {
  final int viewerCount;
  final VoidCallback onViewersTap;
  final VoidCallback onDelete;

  const StoryViewerInsightsBar({
    super.key,
    required this.viewerCount,
    required this.onViewersTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 8.w, 16.h),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onViewersTap,
              borderRadius: BorderRadius.circular(24.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '$viewerCount',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Delete this story',
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.white,
              size: 26.sp,
            ),
          ),
        ],
      ),
    );
  }
}
