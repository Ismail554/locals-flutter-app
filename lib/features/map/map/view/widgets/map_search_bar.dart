import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MapSearchBar extends StatelessWidget {
  final String query;
  final VoidCallback onTap;

  const MapSearchBar({
    super.key,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasQuery = query.trim().isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: AppColors.textSecondary,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  hasQuery ? query : 'Search locals & places',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hasQuery
                        ? AppColors.black
                        : AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
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
