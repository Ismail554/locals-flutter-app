import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/map_mission_args.dart';

class MapLocationDetailCard extends StatelessWidget {
  final MapActiveLocation location;

  const MapLocationDetailCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: location.imageColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.local_cafe_outlined,
              color: AppColors.white.withValues(alpha: 0.7),
              size: 28.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 11.sp, height: 1.3),
                    children: [
                      TextSpan(
                        text: location.category,
                        style: const TextStyle(
                          color: AppColors.actionPink,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      TextSpan(
                        text: ' · ${location.seal}',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  location.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  location.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.levelGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '+${location.points}',
            style: TextStyle(
              color: AppColors.actionPink,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
