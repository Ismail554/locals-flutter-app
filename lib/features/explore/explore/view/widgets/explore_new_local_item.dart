import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';

class ExploreNewLocalItem extends StatelessWidget {
  final ExploreNewLocal local;
  final VoidCallback? onTap;

  const ExploreNewLocalItem({
    super.key,
    required this.local,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.rankListItemBg,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: local.imageColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.storefront_outlined,
                color: AppColors.white.withValues(alpha: 0.7),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.exploreNewCategory(local.category),
                    style: TextStyle(
                      color: AppColors.actionPink,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    local.name,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    local.address,
                    style: TextStyle(
                      color: AppColors.levelGrey,
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
