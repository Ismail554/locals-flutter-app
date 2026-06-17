import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/story_avatar_ring.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/rank_model.dart';

class RankListItem extends StatelessWidget {
  final RankEntry entry;
  final bool hasStory;
  final bool isStoryViewed;
  final VoidCallback? onTap;
  final VoidCallback? onAvatarTap;

  const RankListItem({
    super.key,
    required this.entry,
    this.hasStory = false,
    this.isStoryViewed = false,
    this.onTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = entry.isCurrentUser;
    final avatarSize = 38.w;

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
              GestureDetector(
                onTap: hasStory ? onAvatarTap : null,
                behavior: HitTestBehavior.opaque,
                child: hasStory
                    ? StoryAvatarRing(
                        size: avatarSize,
                        hasStory: true,
                        isViewed: isStoryViewed,
                        child: StoryAvatarPlaceholder(
                          size: avatarSize,
                          backgroundColor: isCurrentUser
                              ? AppColors.actionPink.withOpacity(0.2)
                              : AppColors.chipUnselected,
                          iconColor: isCurrentUser
                              ? AppColors.actionPink
                              : AppColors.textSecondary,
                        ),
                      )
                    : Container(
                        width: avatarSize,
                        height: avatarSize,
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
              ),
              SizedBox(width: 12.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
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
