import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/explore/events_progress_map/model/events_progress_map_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

class EventProgressStopCard extends StatelessWidget {
  final EventProgressStop stop;

  const EventProgressStopCard({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: stop.isCompleted
            ? Border.all(color: AppColors.actionPink, width: 2)
            : null,
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 76.h,
            width: double.infinity,
            child: ColoredBox(
              color: stop.thumbnailColor,
              child: Icon(
                Icons.image_outlined,
                color: AppColors.white.withValues(alpha: 0.5),
                size: 28.sp,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 8.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  stop.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
