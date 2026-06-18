import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/story_avatar_ring.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import '../../model/explore_model.dart';
import 'explore_your_story_avatar.dart';

class ExploreStoryItem extends StatelessWidget {
  final ExploreStory story;
  final VoidCallback? onTap;

  const ExploreStoryItem({super.key, required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72.w,
        child: Column(
          children: [
            if (story.isYourStory && !story.hasStory)
              ExploreYourStoryAvatar(size: 64.w)
            else
              Stack(
                clipBehavior: Clip.none,
                children: [
                  StoryAvatarRing(
                    size: 64.w,
                    hasStory: story.hasStory,
                    isViewed: story.isViewed,
                    child: _StoryThumbnail(story: story),
                  ),
                  if (story.isYourStory && story.hasStory)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: _StoryViewerBadge(count: story.viewers.length),
                    ),
                ],
              ),
            SizedBox(height: 8.h),
            Text(
              story.isYourStory ? context.l10n.exploreYourStory : story.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: story.isYourStory
                    ? AppColors.actionPink
                    : AppColors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryViewerBadge extends StatelessWidget {
  final int count;

  const _StoryViewerBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.remove_red_eye_outlined,
            color: AppColors.white,
            size: 12.sp,
          ),
          if (count > 0) ...[
            SizedBox(width: 3.w),
            Text(
              '$count',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StoryThumbnail extends StatelessWidget {
  final ExploreStory story;

  const _StoryThumbnail({required this.story});

  @override
  Widget build(BuildContext context) {
    if (story.activeSlides.isEmpty) {
      return CircleAvatar(
        backgroundColor: AppColors.chipUnselected,
        child: Icon(
          Icons.person,
          color: AppColors.textSecondary,
          size: 28.sp,
        ),
      );
    }

    final slide = story.activeSlides.last;
    if (slide.imagePath != null) {
      return Image.file(
        File(slide.imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _colorThumb(slide),
      );
    }

    return _colorThumb(slide);
  }

  Widget _colorThumb(StorySlide slide) {
    return Container(
      color: slide.placeholderColor ?? AppColors.chipUnselected,
      child: Icon(
        story.isYourStory ? Icons.person : Icons.image_outlined,
        color: AppColors.white.withValues(alpha: 0.6),
        size: 24.sp,
      ),
    );
  }
}
