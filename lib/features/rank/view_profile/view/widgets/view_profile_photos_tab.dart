import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ViewProfilePhotosTab extends StatelessWidget {
  final List<Color> photoColors;

  const ViewProfilePhotosTab({super.key, required this.photoColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${photoColors.length} CHECK-IN PHOTOS',
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
          itemCount: photoColors.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: photoColors[index],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.image_outlined,
                color: AppColors.white.withValues(alpha: 0.5),
                size: 24.sp,
              ),
            );
          },
        ),
      ],
    );
  }
}
