import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/story_avatar_ring.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String location;
  final String? avatarUrl;
  final bool hasStory;
  final bool isStoryViewed;
  final VoidCallback? onAvatarTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.location,
    this.avatarUrl,
    this.hasStory = false,
    this.isStoryViewed = false,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = 96.w;
    final hasAvatar = avatarUrl != null && avatarUrl!.isNotEmpty;
    final avatar = hasAvatar
        ? CircleAvatar(
            radius: avatarSize / 2,
            backgroundColor: AppColors.chipUnselected,
            backgroundImage: NetworkImage(avatarUrl!),
            onBackgroundImageError: (_, __) {},
          )
        : StoryAvatarPlaceholder(
            size: avatarSize,
            backgroundColor: AppColors.chipUnselected,
            iconColor: AppColors.textSecondary,
          );

    return Column(
      children: [
        GestureDetector(
          onTap: hasStory ? onAvatarTap : null,
          behavior: HitTestBehavior.opaque,
          child: hasStory
              ? StoryAvatarRing(
                  size: avatarSize,
                  hasStory: true,
                  isViewed: isStoryViewed,
                  child: avatar,
                )
              : SizedBox(width: avatarSize, height: avatarSize, child: avatar),
        ),
        SizedBox(height: 12.h),
        Text(
          name,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          location,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
      ],
    );
  }
}
