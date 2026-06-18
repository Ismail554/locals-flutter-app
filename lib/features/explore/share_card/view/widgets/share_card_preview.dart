import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ShareCardPreview extends StatelessWidget {
  final Color previewColor;
  final bool isConfirmed;
  final String? imagePath;
  final VoidCallback? onTap;

  const ShareCardPreview({
    super.key,
    required this.previewColor,
    required this.isConfirmed,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: double.infinity,
          height: 320.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: imagePath == null
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      previewColor,
                      previewColor.withValues(alpha: 0.75),
                    ],
                  )
                : null,
            color: imagePath != null ? AppColors.black : null,
            border: isConfirmed
                ? Border.all(color: AppColors.actionPink, width: 2)
                : null,
          ),
          child: imagePath != null
              ? Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.white.withValues(alpha: 0.8),
                        size: 64.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        context.l10n.shareCardTapToCapture,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.8),
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
