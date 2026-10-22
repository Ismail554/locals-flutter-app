import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/mission_details_model.dart';

class MissionDetailsStopTile extends StatelessWidget {
  final MissionStop stop;
  final VoidCallback? onTap;

  const MissionDetailsStopTile({
    super.key,
    required this.stop,
    this.onTap,
  });

  bool get _isCompleted => stop.status == MissionStopStatus.completed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.rankListItemBg,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _isCompleted
                    ? AppColors.actionPink
                    : AppColors.chipUnselected,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: _isCompleted
                    ? Icon(Icons.check,
                        color: AppColors.white,
                        size: 18.sp)
                    : Text(
                        '${stop.number}',
                        style: TextStyle(
                          color: AppColors.textSub2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stop.name,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${stop.category} · ${stop.address}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.levelGrey,
                      fontSize: 12.sp,
                    ),
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