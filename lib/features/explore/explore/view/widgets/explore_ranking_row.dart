import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';

class ExploreRankingRow extends StatelessWidget {
  final ExploreRankingUser user;

  const ExploreRankingRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final formattedPoints = user.points.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: Text(
              '${user.rank}',
              style: TextStyle(
                color: AppColors.actionPink,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: AppColors.chipUnselected,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Level ${user.level}',
                  style: TextStyle(
                    color: AppColors.levelGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp),
              children: [
                TextSpan(
                  text: formattedPoints,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' pts',
                  style: TextStyle(
                    color: AppColors.actionPink,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
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
