import 'package:flutter/material.dart';
import 'package:locals/shared/theme/app_colors.dart';

abstract final class StoryRingStyle {
  static const storyGradient = LinearGradient(
    colors: [Color(0xFFEA4D70), Color(0xFFFF8FA3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static bool shouldShowRing({required bool hasStory}) => hasStory;

  static Color ringColor({
    required bool hasStory,
    bool isViewed = false,
  }) {
    if (!hasStory) return Colors.transparent;
    if (isViewed) return AppColors.borderGray;
    return AppColors.actionPink;
  }
}
