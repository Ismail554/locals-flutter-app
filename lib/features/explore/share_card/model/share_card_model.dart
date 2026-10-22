import 'package:flutter/material.dart';
import 'package:locals/features/missions/check_in/model/checkin_model.dart';

class ShareCardModel {
  final String cityLabel;
  final int level;
  final int points;
  final int cityPercent;
  final Color previewColor;
  final bool isConfirmed;
  final String? imagePath;
  final bool isSaving;
  final bool isSaved;
  final String caption;

  // Real check-in submission state (POST /social/checkins/)
  final bool isSubmitting;
  final String? submitError;
  final List<CheckInAchievement> unlockedAchievements;

  const ShareCardModel({
    required this.cityLabel,
    required this.level,
    required this.points,
    required this.cityPercent,
    required this.previewColor,
    this.isConfirmed = false,
    this.imagePath,
    this.isSaving = false,
    this.isSaved = false,
    this.caption = '',
    this.isSubmitting = false,
    this.submitError,
    this.unlockedAchievements = const [],
  });

  ShareCardModel copyWith({
    bool? isConfirmed,
    Color? previewColor,
    String? imagePath,
    bool clearImagePath = false,
    bool? isSaving,
    bool? isSaved,
    String? caption,
    bool? isSubmitting,
    String? submitError,
    bool clearSubmitError = false,
    int? level,
    int? points,
    int? cityPercent,
    List<CheckInAchievement>? unlockedAchievements,
  }) {
    return ShareCardModel(
      cityLabel: cityLabel,
      level: level ?? this.level,
      points: points ?? this.points,
      cityPercent: cityPercent ?? this.cityPercent,
      previewColor: previewColor ?? this.previewColor,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      imagePath: clearImagePath ? null : (imagePath ?? this.imagePath),
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      caption: caption ?? this.caption,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitError: clearSubmitError ? null : (submitError ?? this.submitError),
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
    );
  }
}