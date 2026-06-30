import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';

class ExploreRouteCard extends StatelessWidget {
  final ExploreFeaturedRoute route;
  final VoidCallback? onTap;

  const ExploreRouteCard({
    super.key,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          width: double.infinity,
          height: 180.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: route.imageColor),
              if (route.imageUrl != null)
                Image.network(
                  route.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return _placeholderIcon();
                  },
                  errorBuilder: (_, __, ___) => _placeholderIcon(),
                )
              else
                _placeholderIcon(),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.black.withValues(alpha: 0.65),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        route.label,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.85),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        route.title,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        route.subtitle,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.9),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
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

  Widget _placeholderIcon() {
    return Positioned.fill(
      child: Icon(
        Icons.landscape_outlined,
        color: AppColors.white.withValues(alpha: 0.25),
        size: 80.sp,
      ),
    );
  }
}