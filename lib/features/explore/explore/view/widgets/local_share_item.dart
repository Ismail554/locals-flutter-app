import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/explore/explore/model/explore_model.dart';

class LocalShareItem extends StatelessWidget {
  final ExploreLocalShare share;
  final VoidCallback onTap;

  const LocalShareItem({super.key, required this.share, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          decoration: BoxDecoration(
            color: share.imageColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            children: [
              // Placeholder Icon
              const Center(
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
              // Like Count Badge
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite, color: Colors.red, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${share.likeCount} likes',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
