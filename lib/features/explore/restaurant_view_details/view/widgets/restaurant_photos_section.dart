import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/explore/restaurant_view_details/model/restaurant_view_details_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantPhotosSection extends StatelessWidget {
  final List<RestaurantPhoto> photos;
  final ValueChanged<RestaurantPhoto> onPhotoTap;

  const RestaurantPhotosSection({
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
          'Photos',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final photo = photos[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onPhotoTap(photo),
                  borderRadius: BorderRadius.circular(14.r),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: ColoredBox(
                        color: photo.color,
                        child: Icon(
                          Icons.image_outlined,
                          color: AppColors.white.withValues(alpha: 0.5),
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
