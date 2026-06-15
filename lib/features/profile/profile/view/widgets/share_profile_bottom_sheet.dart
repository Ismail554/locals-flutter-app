import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/share/share_bottom_sheet_shell.dart';
import 'package:locals/shared/components/share/share_link_row.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ShareProfileBottomSheet extends StatelessWidget {
  final String name;
  final int level;
  final Color avatarColor;
  final String shareUrl;

  const ShareProfileBottomSheet({
    super.key,
    required this.name,
    required this.level,
    required this.avatarColor,
    required this.shareUrl,
  });

  static Future<void> show(
    BuildContext context, {
    required String name,
    required int level,
    required Color avatarColor,
    required String shareUrl,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ShareProfileBottomSheet(
        name: name,
        level: level,
        avatarColor: avatarColor,
        shareUrl: shareUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ShareBottomSheetShell(
        title: 'Share your profile',
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.chipUnselected,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    width: 56.w,
                    height: 56.w,
                    child: ColoredBox(
                      color: avatarColor,
                      child: Icon(
                        Icons.person,
                        color: AppColors.white.withValues(alpha: 0.8),
                        size: 28.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level $level',
                        style: TextStyle(
                          color: AppColors.actionPink,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        name,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          ShareLinkRow(url: shareUrl),
        ],
      ),
    );
  }
}
