import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/components/story_avatar_ring.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ViewProfileHeaderSection extends StatelessWidget {
  final String name;
  final int level;
  final String location;
  final bool hasStory;
  final bool isStoryViewed;
  final VoidCallback? onAvatarTap;

  const ViewProfileHeaderSection({
    super.key,
    required this.name,
    required this.level,
    required this.location,
    required this.hasStory,
    this.isStoryViewed = false,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = 96.w;
    final avatar = StoryAvatarPlaceholder(
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
          context.l10n.viewProfileLevelLocation(level, location),
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
