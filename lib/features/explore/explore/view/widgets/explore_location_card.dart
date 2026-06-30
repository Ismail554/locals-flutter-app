import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';

class ExploreLocationCard extends StatelessWidget {
  final ExploreFeaturedLocation location;

  const ExploreLocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 176.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              color: location.imageColor,
              child: location.imageUrl != null
                  ? Image.network(
                      location.imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return _placeholderIcon();
                      },
                      errorBuilder: (_, __, ___) => _placeholderIcon(),
                    )
                  : _placeholderIcon(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location.category,
                  style: TextStyle(
                    color: AppColors.actionPink,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        location.name,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '+${location.points} pts',
                      style: TextStyle(
                        color: AppColors.levelGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderIcon() {
    return Center(
      child: Icon(
        Icons.image_outlined,
        color: AppColors.white.withValues(alpha: 0.6),
        size: 32.sp,
      ),
    );
  }
}
