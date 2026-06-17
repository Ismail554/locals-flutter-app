import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ViewProfilePhotosTab extends StatelessWidget {
  final List<CheckInPhoto> photos;
  final ValueChanged<CheckInPhoto> onPhotoTap;

  const ViewProfilePhotosTab({
    super.key,
    required this.photos,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${photos.length} CHECK-IN PHOTOS',
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onPhotoTap(photo),
                borderRadius: BorderRadius.circular(12.r),
                child: Ink(
                  decoration: BoxDecoration(
                    color: photo.previewColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.white.withValues(alpha: 0.5),
                    size: 24.sp,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
