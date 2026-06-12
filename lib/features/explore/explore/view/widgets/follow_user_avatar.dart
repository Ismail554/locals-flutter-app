import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';
import 'story_ring_style.dart';

class FollowUserAvatar extends StatelessWidget {
  final ExploreStory? story;
  final double size;

  const FollowUserAvatar({
    super.key,
    required this.story,
    required this.size,
  });

  bool get _hasStory => story != null && story!.hasStory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: StoryRingStyle.borderColor(hasStory: _hasStory),
          width: 2,
        ),
      ),
      child: ClipOval(child: _AvatarContent(story: story)),
    );
  }
}

class _AvatarContent extends StatelessWidget {
  final ExploreStory? story;

  const _AvatarContent({required this.story});

  @override
  Widget build(BuildContext context) {
    if (story == null || story!.slides.isEmpty) {
      return CircleAvatar(
        backgroundColor: AppColors.chipUnselected,
        child: Icon(
          Icons.person,
          color: AppColors.textSecondary,
          size: 28.sp,
        ),
      );
    }

    final slide = story!.slides.last;
    if (slide.imagePath != null) {
      return Image.file(
        File(slide.imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) => _colorThumb(slide),
      );
    }

    return _colorThumb(slide);
  }

  Widget _colorThumb(StorySlide slide) {
    return Container(
      color: slide.placeholderColor ?? AppColors.chipUnselected,
      child: Icon(
        Icons.image_outlined,
        color: AppColors.white.withValues(alpha: 0.6),
        size: 24.sp,
      ),
    );
  }
}
