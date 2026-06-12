import 'package:flutter/material.dart';
import 'package:locals/shared/theme/app_colors.dart';

abstract final class StoryRingStyle {
  static Color borderColor({
    required bool hasStory,
    bool isViewed = false,
  }) {
    if (!hasStory) return AppColors.borderGray;
    if (isViewed) return AppColors.borderGray;
    return AppColors.actionPink;
  }
}
