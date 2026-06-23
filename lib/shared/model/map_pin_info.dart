import 'package:flutter/material.dart';
import 'map_pin_tag.dart';

class MapPinInfo {
  final String id;
  final String name;
  final int level;
  final double x;
  final double y;
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
    required this.x,
    required this.y,
    required this.tag,
    required this.visited,
    this.category,
    this.address,
    this.points,
    this.accentColor,
  });
}