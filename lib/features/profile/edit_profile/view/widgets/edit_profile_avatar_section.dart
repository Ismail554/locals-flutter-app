import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class EditProfileAvatarSection extends StatelessWidget {
  final Color avatarColor;
  final String? avatarImagePath;
  final String? avatarUrl;
  final bool isLoading;
  final VoidCallback onChangePhoto;

  const EditProfileAvatarSection({
    super.key,
    required this.avatarColor,
    this.avatarImagePath,
    this.avatarUrl,
    this.isLoading = false,
    required this.onChangePhoto,
  });

  @override
  Widget build(BuildContext context) {
    // A freshly picked local image takes priority over the server avatar
    final hasLocalImage =
        avatarImagePath != null && File(avatarImagePath!).existsSync();
    final hasNetworkImage = !hasLocalImage && avatarUrl != null;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.actionPink, width: 3),
            ),
            child: CircleAvatar(
              radius: 52.r,
              backgroundColor: avatarColor,
              backgroundImage: hasLocalImage
                  ? FileImage(File(avatarImagePath!))
                  : hasNetworkImage
                      ? NetworkImage(avatarUrl!) as ImageProvider
                      : null,
              child: hasLocalImage || hasNetworkImage
                  ? null
                  : Icon(
                      Icons.person,
                      size: 52.sp,
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
            ),
          ),
          Positioned(
            right: 4.w,
            bottom: 4.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onChangePhoto,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: isLoading
                        ? AppColors.actionPink.withValues(alpha: 0.7)
                        : AppColors.actionPink,
                    shape: BoxShape.circle,
                  ),
                  child: isLoading
                      ? Padding(
                          padding: EdgeInsets.all(8.w),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.white,
                          size: 18.sp,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}