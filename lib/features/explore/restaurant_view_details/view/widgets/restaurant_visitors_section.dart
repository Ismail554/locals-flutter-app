import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantVisitorsSection extends StatelessWidget {
  final int visitorCount;
  final List<Color> avatarColors;

  const RestaurantVisitorsSection({
    super.key,
    required this.visitorCount,
    required this.avatarColors,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = visitorCount - avatarColors.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Visitors',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              ' ($visitorCount)',
              style: TextStyle(
                color: AppColors.actionPink,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 40.w,
          child: Row(
            children: [
              for (var i = 0; i < avatarColors.length; i++)
                Transform.translate(
                  offset: Offset(-10.w * i, 0),
                  child: _AvatarCircle(color: avatarColors[i]),
                ),
              if (remaining > 0)
                Transform.translate(
                  offset: Offset(-10.w * avatarColors.length, 0),
                  child: _OverflowAvatar(count: remaining),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final Color color;

  const _AvatarCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Icon(
        Icons.person,
        color: AppColors.white.withValues(alpha: 0.7),
        size: 20.sp,
      ),
    );
  }
}

class _OverflowAvatar extends StatelessWidget {
  final int count;

  const _OverflowAvatar({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: AppColors.chipUnselected,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: TextStyle(
            color: AppColors.textSub2,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
