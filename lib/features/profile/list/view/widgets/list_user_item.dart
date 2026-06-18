import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/story_avatar_ring.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/list_model.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ListUserItem extends StatelessWidget {
  final ListUser user;
  final ListTab tab;
  final bool hasStory;
  final bool isStoryViewed;
  final VoidCallback onActionTap;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onProfileTap;

  const ListUserItem({
    super.key,
    required this.user,
    required this.tab,
    required this.onActionTap,
    this.hasStory = false,
    this.isStoryViewed = false,
    this.onAvatarTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = 44.w;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onProfileTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.rankListItemBg,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
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
                          iconColor: AppColors.textSecondary,
                        ),
                      )
                    : StoryAvatarPlaceholder(
                        size: avatarSize,
                        iconColor: AppColors.textSecondary,
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
                      user.name,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      tab == ListTab.following && user.followsYou
                          ? context.l10n.listLevelFollowsYou(user.level)
                          : context.l10n.commonLevel(user.level),
                      style: TextStyle(
                        color: AppColors.levelGrey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (tab == ListTab.followers)
                SizedBox(
                  height: 32.h,
                  child: TextButton(
                    onPressed: onActionTap,
                    style: TextButton.styleFrom(
                      backgroundColor: user.isFollowing
                          ? AppColors.chipUnselected
                          : AppColors.actionPink,
                      foregroundColor:
                          user.isFollowing ? AppColors.black : AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      user.isFollowing ? context.l10n.commonFollowing : context.l10n.commonFollow,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: onActionTap,
                  child: Text(
                    context.l10n.commonFollowing,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
