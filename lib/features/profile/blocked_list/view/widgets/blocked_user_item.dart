import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/blocked_list_model.dart';

class BlockedUserItem extends StatelessWidget {
  final BlockedUser user;
  final VoidCallback onUnblock;

  const BlockedUserItem({
    super.key,
    required this.user,
    required this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.rankListItemBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.chipUnselected,
            child: Icon(Icons.person, color: AppColors.textSecondary, size: 22.sp),
          ),
          SizedBox(width: 12.w),
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
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
          GestureDetector(
            onTap: onUnblock,
            child: Text(
              'Unblock',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
