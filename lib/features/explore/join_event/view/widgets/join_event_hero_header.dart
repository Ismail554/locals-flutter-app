import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class JoinEventHeroHeader extends StatelessWidget {
  final String sponsor;
  final String title;
  final String dateLabel;
  final Color heroColor;
  final VoidCallback onBack;

  const JoinEventHeroHeader({
    super.key,
    required this.sponsor,
    required this.title,
    required this.dateLabel,
    required this.heroColor,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 220.h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: heroColor),
            Positioned.fill(
              child: Icon(
                Icons.landscape_outlined,
                color: AppColors.white.withValues(alpha: 0.2),
                size: 72.sp,
              ),
            ),
            Positioned(
              top: 12.h,
              left: 12.w,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(22.r),
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      color: AppColors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'Sponsored · $sponsor',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    dateLabel,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
