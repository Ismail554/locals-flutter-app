import 'package:flutter/material.dart';

class CheckInPhoto {
  final String? id;
  final String? imageUrl;
  final Color previewColor;
  final String locationName;
  final String timeAgo;
  final String caption;
  final int likes;
  final String? userInitial;

  const CheckInPhoto({
    this.id,
    this.imageUrl,
    required this.previewColor,
    required this.locationName,
    required this.timeAgo,
    required this.caption,
    required this.likes,
    this.userInitial,
  });
}