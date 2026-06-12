import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';
import 'explore_your_story_avatar.dart';
import 'story_ring_style.dart';

class ExploreStoryItem extends StatelessWidget {
  final ExploreStory story;
  final VoidCallback? onTap;

  const ExploreStoryItem({super.key, required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor = StoryRingStyle.borderColor(
      hasStory: story.hasStory,
      isViewed: story.isViewed,
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72.w,
        child: Column(
          children: [
            if (story.isYourStory && !story.hasStory)
              ExploreYourStoryAvatar(size: 64.w)
            else
              Container(
                width: 64.w,
                height: 64.w,
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 2),
                ),
                child: ClipOval(child: _StoryThumbnail(story: story)),
              ),
            SizedBox(height: 8.h),
            Text(
              story.name,
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

class _StoryThumbnail extends StatelessWidget {
  final ExploreStory story;

  const _StoryThumbnail({required this.story});

  @override
  Widget build(BuildContext context) {
    if (story.slides.isEmpty) {
      return CircleAvatar(
        backgroundColor: AppColors.chipUnselected,
        child: Icon(
          Icons.person,
          color: AppColors.textSecondary,
          size: 28.sp,
        ),
      );
    }

    final slide = story.slides.last;
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
