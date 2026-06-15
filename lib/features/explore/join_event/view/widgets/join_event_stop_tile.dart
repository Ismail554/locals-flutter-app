import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/explore/join_event/model/join_event_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

class JoinEventStopTile extends StatelessWidget {
  final JoinEventRouteStop stop;
  final VoidCallback? onTap;

  const JoinEventStopTile({
    super.key,
    required this.stop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24.w,
                child: Text(
                  '${stop.number}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(
                  width: 48.w,
                  height: 48.w,
                  child: ColoredBox(
                    color: stop.thumbnailColor,
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.white.withValues(alpha: 0.5),
                      size: 20.sp,
                    ),
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
                      stop.category,
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
      ),
    );
  }
}
