import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/story_avatar_ring.dart';
import 'package:locals/shared/theme/app_assets.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/rank_model.dart';

class RankPodium extends StatelessWidget {
  final List<PodiumUser> users;
  final ValueChanged<PodiumUser>? onUserTap;
  final ValueChanged<PodiumUser>? onAvatarTap;
  final bool Function(PodiumUser user)? hasStory;
  final bool Function(PodiumUser user)? isStoryViewed;

  const RankPodium({
    super.key,
    required this.users,
    this.onUserTap,
    this.onAvatarTap,
    this.hasStory,
    this.isStoryViewed,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return SizedBox(
        height: 240.h,
        child: const Center(
          child: Text(
            'Loading top players...',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    // Safe extraction with fallbacks
    final first = users.where((u) => u.rank == 1).firstOrNull ??
        const PodiumUser(rank: 1, name: '-', score: 0);

    final second = users.where((u) => u.rank == 2).firstOrNull ??
        const PodiumUser(rank: 2, name: '-', score: 0);

    final third = users.where((u) => u.rank == 3).firstOrNull ??
        const PodiumUser(rank: 3, name: '-', score: 0);

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
              hasStory: hasStory?.call(second) ?? false,
              isStoryViewed: isStoryViewed?.call(second) ?? false,
              onTap: onUserTap == null ? null : () => onUserTap!(second),
              onAvatarTap: onAvatarTap == null ? null : () => onAvatarTap!(second),
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
              hasStory: hasStory?.call(first) ?? false,
              isStoryViewed: isStoryViewed?.call(first) ?? false,
              onTap: onUserTap == null ? null : () => onUserTap!(first),
              onAvatarTap: onAvatarTap == null ? null : () => onAvatarTap!(first),
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
              hasStory: hasStory?.call(third) ?? false,
              isStoryViewed: isStoryViewed?.call(third) ?? false,
              onTap: onUserTap == null ? null : () => onUserTap!(third),
              onAvatarTap: onAvatarTap == null ? null : () => onAvatarTap!(third),
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
  final bool hasStory;
  final bool isStoryViewed;
  final VoidCallback? onTap;
  final VoidCallback? onAvatarTap;

  const _PodiumColumn({
    super.key,
    required this.user,
    required this.barHeight,
    required this.avatarSize,
    required this.isFirst,
    required this.hasStory,
    required this.isStoryViewed,
    this.onTap,
    this.onAvatarTap,
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
              // Crown
              if (isFirst) ...[
                Image.asset(
                  AppAssets.rankTop,
                  width: 28.w,
                  height: 28.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 6.h),
              ] else
                SizedBox(height: 34.h),

              // Avatar
              GestureDetector(
                onTap: hasStory ? onAvatarTap : onTap,
                behavior: HitTestBehavior.opaque,
                child: _PodiumAvatar(
                  size: avatarSize,
                  isFirst: isFirst,
                  hasStory: hasStory,
                  isStoryViewed: isStoryViewed,
                ),
              ),
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
  final bool hasStory;
  final bool isStoryViewed;

  const _PodiumAvatar({
    super.key,
    required this.size,
    required this.isFirst,
    required this.hasStory,
    required this.isStoryViewed,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = StoryAvatarPlaceholder(
      size: size,
      backgroundColor: AppColors.chipUnselected,
      iconColor: AppColors.textSecondary,
    );

    if (hasStory) {
      return StoryAvatarRing(
        size: size,
        hasStory: true,
        isViewed: isStoryViewed,
        child: avatar,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: avatar,
    );
  }
}