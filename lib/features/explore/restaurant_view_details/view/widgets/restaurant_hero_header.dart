import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/features/explore/restaurant_view_details/model/restaurant_view_details_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantHeroHeader extends StatelessWidget {
  final RestaurantViewDetailsModel restaurant;
  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const RestaurantHeroHeader({
    super.key,
    required this.restaurant,
    required this.onBack,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Real image or color fallback — unchanged visual behaviour
          if (restaurant.heroImageUrl != null)
            Image.network(
              restaurant.heroImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return ColoredBox(color: restaurant.heroColor);
              },
              errorBuilder: (_, __, ___) =>
                  ColoredBox(color: restaurant.heroColor),
            )
          else
            ColoredBox(color: restaurant.heroColor),

          // Fallback icon — only visible when no image URL
          if (restaurant.heroImageUrl == null)
            Positioned.fill(
              child: Icon(
                Icons.image_outlined,
                color: AppColors.white.withValues(alpha: 0.25),
                size: 80.sp,
              ),
            ),

          // Top controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              children: [
                _CircleButton(icon: Icons.chevron_left, onTap: onBack),
                const Spacer(),
                _CircleButton(icon: Icons.ios_share_outlined, onTap: onShare),
                SizedBox(width: 8.w),
                _CircleButton(
                  icon: restaurant.isSaved
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                  onTap: onSave,
                ),
              ],
            ),
          ),

          // Bottom labels
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Tag(label: restaurant.category),
                    if (restaurant.hasLocalsSeal) ...[
                      SizedBox(width: 8.w),
                      _SealTag(),
                    ],
                    if (restaurant.businessOfTheMonth) ...[
                      SizedBox(width: 8.w),
                      _BusinessMonthTag(),
                    ],
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  restaurant.name,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessMonthTag extends StatelessWidget {
  const _BusinessMonthTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.actionPink,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events, color: Colors.white, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            context.l10n.busniessOfTheMonth,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.white, size: 22.sp),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SealTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.actionPink,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: AppColors.white, size: 12.sp),
          SizedBox(width: 4.w),
          Text(
            context.l10n.restaurantLocalsSeal,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}