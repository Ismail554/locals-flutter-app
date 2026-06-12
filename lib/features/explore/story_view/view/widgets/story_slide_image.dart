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
    if (slide.imagePath != null) {
      return Image.file(
        File(slide.imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    return _placeholder();
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
