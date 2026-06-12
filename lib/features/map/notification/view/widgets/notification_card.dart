import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.isRead
          ? AppColors.rankListItemBg
          : AppColors.lightPink,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    item.emoji,
                    style: TextStyle(fontSize: 22.sp, height: 1),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (!item.isRead) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  width: 7.w,
                                  height: 7.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.actionPink,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Text(
                          item.timeAgo,
                          style: TextStyle(
                            color: AppColors.levelGrey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.message,
                      style: TextStyle(
                        color: AppColors.levelGrey,
                        fontSize: 13.sp,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
