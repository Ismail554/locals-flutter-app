import 'package:flutter/material.dart';

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
  });

  ShareCardModel copyWith({
    bool? isConfirmed,
    Color? previewColor,
    String? imagePath,
    bool clearImagePath = false,
    bool? isSaving,
    bool? isSaved,
  }) {
    return ShareCardModel(
      cityLabel: cityLabel,
      level: level,
      points: points,
      cityPercent: cityPercent,
      previewColor: previewColor ?? this.previewColor,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      imagePath: clearImagePath ? null : (imagePath ?? this.imagePath),
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
