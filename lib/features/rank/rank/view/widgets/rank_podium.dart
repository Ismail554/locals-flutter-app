import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_assets.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/rank_model.dart';

class RankPodium extends StatelessWidget {
  final List<PodiumUser> users;
  final ValueChanged<PodiumUser>? onUserTap;

  const RankPodium({super.key, required this.users, this.onUserTap});

  @override
  Widget build(BuildContext context) {
    final first = users.firstWhere((u) => u.rank == 1);
    final second = users.firstWhere((u) => u.rank == 2);
    final third = users.firstWhere((u) => u.rank == 3);

    // Bar heights in logical pixels — no dependency on a fixed parent height
    const double barFirst = 170;
    const double barSecond = 120;
    const double barThird = 90;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: _PodiumColumn(
              user: second,
              barHeight: barSecond.h,
              avatarSize: 60.w,
              isFirst: false,
              onTap: onUserTap == null ? null : () => onUserTap!(second),
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: _PodiumColumn(
              user: first,
              barHeight: barFirst.h,
              avatarSize: 80.w,
              isFirst: true,
              onTap: onUserTap == null ? null : () => onUserTap!(first),
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: _PodiumColumn(
              user: third,
              barHeight: barThird.h,
              avatarSize: 60.w,
              isFirst: false,
              onTap: onUserTap == null ? null : () => onUserTap!(third),
            ),
          ),
        ],
      ),
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  final PodiumUser user;
  final double barHeight;
  final double avatarSize;
  final bool isFirst;

  final VoidCallback? onTap;

  const _PodiumColumn({
    required this.user,
    required this.barHeight,
    required this.avatarSize,
    required this.isFirst,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
        // Crown — only rank 1
        if (isFirst) ...[
          Image.asset(
            AppAssets.rankTop,
            width: 28.w,
            height: 28.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 6.h),
        ] else
          // Reserve same vertical space so 2nd/3rd columns align properly
          SizedBox(height: 34.h),

        // Avatar
        _PodiumAvatar(size: avatarSize, isFirst: isFirst),
        SizedBox(height: 8.h),

        // Name
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 3.h),

        // Score
        Text(
          _formatScore(user.score),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSub2,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
            ],
          ),
        ),
        SizedBox(height: 10.h),

        // Bar
        Container(
          height: barHeight,
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.h),
          decoration: ShapeDecoration(
            color: isFirst ? AppColors.actionPink : AppColors.rankPodiumDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
          ),
          alignment: Alignment.topCenter,
          child: Text(
            '${user.rank}',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }

  String _formatScore(int score) {
    return score.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
  }
}

class _PodiumAvatar extends StatelessWidget {
  final double size;
  final bool isFirst;

  const _PodiumAvatar({required this.size, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.chipUnselected,
        shape: BoxShape.circle,
        border: isFirst
            ? Border.all(color: AppColors.actionPink, width: 2.5)
            : null,
      ),
      child: Icon(
        Icons.person,
        color: AppColors.textSecondary,
        size: size * 0.5,
      ),
    );
  }
}