import 'package:flutter/material.dart';

class CheckInPhoto {
  final Color previewColor;
  final String locationName;
  final String timeAgo;
  final String caption;
  final int likes;

  const CheckInPhoto({
    required this.previewColor,
    required this.locationName,
    required this.timeAgo,
    required this.caption,
    required this.likes,
  });
}
