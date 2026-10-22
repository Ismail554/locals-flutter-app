import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../../explore/model/explore_model.dart';

class StorySlideImage extends StatelessWidget {
  final StorySlide slide;

  const StorySlideImage({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    // 1. Network image from API
    if (slide.imageUrl != null) {
      return Image.network(
        slide.imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return _loading();
        },
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    // 2. Local file (camera / gallery pick before upload)
    if (slide.imagePath != null) {
      return Image.file(
        File(slide.imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    // 3. Color placeholder fallback
    return _placeholder();
  }

  Widget _loading() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: slide.placeholderColor ?? AppColors.chipUnselected,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: slide.placeholderColor ?? AppColors.chipUnselected,
      child: Icon(
        Icons.image_outlined,
        color: AppColors.white.withValues(alpha: 0.5),
        size: 64.sp,
      ),
    );
  }
}