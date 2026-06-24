import 'package:flutter/material.dart';
import 'map_pin_tag.dart';

class MapPinInfo {
  final String id;
  final String name;

  /// Optional: useful for UI logic
  final int level;

  /// 🌍 REAL WORLD COORDINATES (IMPORTANT)
  final double lat;
  final double lng;

  final MapPinTag tag;
  final bool visited;

  final String? category;
  final String? address;
  final int? points;
  final Color? accentColor;

  const MapPinInfo({
    required this.id,
    required this.name,
    required this.level,
    required this.lat,
    required this.lng,
    required this.tag,
    required this.visited,
    this.category,
    this.address,
    this.points,
    this.accentColor,
  });
}