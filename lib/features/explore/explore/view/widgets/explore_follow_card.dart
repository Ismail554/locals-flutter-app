import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';
import 'follow_user_avatar.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ExploreFollowCard extends StatelessWidget {
  final ExploreFollowUser user;
  final ExploreStory? story;
  final VoidCallback onCardTap;
  final VoidCallback onAvatarTap;
  final VoidCallback onFollowTap;

  const ExploreFollowCard({
    super.key,
    required this.user,
    required this.story,
    required this.onCardTap,
    required this.onAvatarTap,
    required this.onFollowTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.rankListItemBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCardTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onAvatarTap,
                    child: FollowUserAvatar(story: story, size: 56.w),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Level ${user.level}',
                    style: TextStyle(
                      color: AppColors.levelGrey,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: TextButton(
                      onPressed: onFollowTap,
                      style: TextButton.styleFrom(
                        backgroundColor: user.isFollowing
                            ? AppColors.chipUnselected
                            : AppColors.actionPink,
                        foregroundColor: user.isFollowing
                            ? AppColors.textSub2
                            : AppColors.white,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
