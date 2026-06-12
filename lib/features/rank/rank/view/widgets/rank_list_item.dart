import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/rank_model.dart';

class RankListItem extends StatelessWidget {
  final RankEntry entry;
  final VoidCallback? onTap;

  const RankListItem({super.key, required this.entry, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = entry.isCurrentUser;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.actionPink.withOpacity(0.12)
            : AppColors.rankListItemBg,
        borderRadius: BorderRadius.circular(16.r),
        border: isCurrentUser
            ? Border.all(
                color: AppColors.actionPink.withOpacity(0.4),
                width: 1,
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Rank number
          SizedBox(
            width: 24.w,
            child: Text(
              '${entry.rank}',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Avatar
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? AppColors.actionPink.withOpacity(0.2)
                  : AppColors.chipUnselected,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: isCurrentUser
                  ? AppColors.actionPink
                  : AppColors.textSecondary,
              size: 20.w,
            ),
          ),
          SizedBox(width: 12.w),

          // Name + level — no fixed height, no spacer between them
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Level ${entry.level}',
                  style: TextStyle(
                    color: AppColors.textSub2,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Score
          Text(
            _formatScore(entry.score),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }

  String _formatScore(int score) {
    return score.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
  }
}