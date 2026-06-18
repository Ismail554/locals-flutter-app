import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/share/share_bottom_sheet_shell.dart';
import 'package:locals/shared/components/share/share_link_row.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ShareLocationBottomSheet extends StatelessWidget {
  final String category;
  final String name;
  final Color imageColor;
  final String shareUrl;

  const ShareLocationBottomSheet({
    super.key,
    required this.category,
    required this.name,
    required this.imageColor,
    required this.shareUrl,
  });

  static Future<void> show(
    BuildContext context, {
    required String category,
    required String name,
    required Color imageColor,
    required String shareUrl,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ShareLocationBottomSheet(
        category: category,
        name: name,
        imageColor: imageColor,
        shareUrl: shareUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ShareBottomSheetShell(
        title: context.l10n.shareLocationTitle,
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
                      color: imageColor,
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.white.withValues(alpha: 0.6),
                        size: 24.sp,
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
                        category,
                        style: TextStyle(
                          color: AppColors.actionPink,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
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
