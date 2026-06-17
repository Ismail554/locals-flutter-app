import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/story_ring_style.dart';
import 'package:locals/shared/theme/app_colors.dart';

class StoryAvatarRing extends StatelessWidget {
  final double size;
  final bool hasStory;
  final bool isViewed;
  final Widget child;

  const StoryAvatarRing({
    super.key,
    required this.size,
    required this.hasStory,
    required this.child,
    this.isViewed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!StoryRingStyle.shouldShowRing(hasStory: hasStory)) {
      return SizedBox(width: size, height: size, child: child);
    }

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isViewed ? null : StoryRingStyle.storyGradient,
        border: isViewed
            ? Border.all(
                color: StoryRingStyle.ringColor(
                  hasStory: true,
                  isViewed: true,
                ),
                width: 2,
              )
            : null,
      ),
      child: ClipOval(child: child),
    );
  }
}

class StoryAvatarPlaceholder extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;

  const StoryAvatarPlaceholder({
    super.key,
    required this.size,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: backgroundColor ?? AppColors.chipUnselected,
        child: Icon(
          Icons.person,
          color: iconColor ?? AppColors.textSecondary,
          size: size * 0.5,
        ),
      ),
    );
  }
}
