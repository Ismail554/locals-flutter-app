import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

enum ImageViewType {
  localShare,   // User avatar + name
  checkIn,      // Location icon + place name
}

class CheckInImageView extends StatelessWidget {
  final CheckInPhoto photo;
  final VoidCallback onClose;
  final ImageViewType viewType;

  const CheckInImageView({
    super.key,
    required this.photo,
    required this.onClose,
    this.viewType = ImageViewType.localShare,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image Area
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ColoredBox(
                        color: photo.previewColor,
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white54,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                    // Close Button
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onClose,
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: AppColors.black,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom Info Area - Two Different Designs
                Container(
                  width: double.infinity,
                  color: AppColors.white,
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (viewType == ImageViewType.localShare)
                        _buildLocalShareHeader()
                      else
                        _buildCheckInHeader(),

                      SizedBox(height: 12.h),

                      // Caption
                      Text(
                        photo.caption,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Likes
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 18.sp,
                            color: Colors.redAccent,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '${photo.likes} likes',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocalShareHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: const Color(0xFF8E4DFF),
          child: Text(
            photo.userInitial ?? 'M',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              photo.locationName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              photo.timeAgo,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckInHeader() {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 20.sp,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: 6.w),
        Text(
          photo.locationName,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const Spacer(),
        Text(
          photo.timeAgo,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}