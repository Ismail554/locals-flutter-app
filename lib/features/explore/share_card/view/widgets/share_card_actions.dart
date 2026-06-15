import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ShareCardActions extends StatelessWidget {
  final bool isConfirmed;
  final bool hasImage;
  final bool isSaving;
  final bool isSaved;
  final VoidCallback onRetake;
  final VoidCallback onConfirm;
  final VoidCallback onAddToStory;
  final VoidCallback onSaveImage;
  final VoidCallback onDone;

  const ShareCardActions({
    super.key,
    required this.isConfirmed,
    required this.hasImage,
    required this.isSaving,
    required this.isSaved,
    required this.onRetake,
    required this.onConfirm,
    required this.onAddToStory,
    required this.onSaveImage,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: OutlinedButton.icon(
                onPressed: onRetake,
                icon: Icon(Icons.refresh, size: 18.sp),
                label: const Text('Retake'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.levelGrey,
                  side: const BorderSide(color: AppColors.borderGray),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: OutlinedButton.icon(
                onPressed: onConfirm,
                icon: Icon(
                  isConfirmed ? Icons.check_circle : Icons.check_circle_outline,
                  size: 18.sp,
                ),
                label: const Text('Confirm'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: hasImage
                      ? AppColors.actionPink
                      : AppColors.levelGrey,
                  side: BorderSide(
                    color: isConfirmed
                        ? AppColors.actionPink
                        : hasImage
                            ? AppColors.borderGray
                            : AppColors.borderGray.withValues(alpha: 0.6),
                    width: isConfirmed ? 2 : 1,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _SecondaryActionButton(
                icon: Icons.add_circle_outline,
                label: 'Add to Story',
                onTap: onAddToStory,
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _SecondaryActionButton(
                icon: isSaved ? Icons.check_circle_outline : Icons.download_outlined,
                label: isSaving
                    ? 'Saving...'
                    : isSaved
                        ? 'Saved'
                        : 'Save Image',
                onTap: hasImage && !isSaving ? onSaveImage : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onDone,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.chipUnselected,
              foregroundColor: AppColors.black,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.r),
              ),
            ),
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _SecondaryActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return Material(
      color: AppColors.chipUnselected,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Opacity(
          opacity: enabled ? 1 : 0.45,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              children: [
                Icon(icon, color: AppColors.actionPink, size: 24.sp),
                SizedBox(height: 6.h),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
