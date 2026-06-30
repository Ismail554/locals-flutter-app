import 'package:flutter/material.dart';
import 'map_pin_tag.dart';

class MapPinInfo {
  final String id;
  final String name;

  /// Optional: useful for UI logic
  final int level;

  /// 🌍 REAL WORLD COORDINATES
  final double lat;
  final double lng;

  final MapPinTag tag;
  final bool visited;

  final String? category;
  final String? categorySlug;
  final String? address;
  final int? points;
  final Color? accentColor;
  final String? imageUrl;
  final String? placeType; // "BUSINESS" | "POI" | "EVENT"
  final String? visitStatus; // "UNVISITED" | "VISITED" | "CHECKED_IN"

  const MapPinInfo({
    required this.id,
    required this.name,
    required this.level,
    required this.lat,
    required this.lng,
    required this.tag,
    required this.visited,
    this.category,
    this.categorySlug,
    this.address,
    this.points,
    this.accentColor,
    this.imageUrl,
    this.placeType,
    this.visitStatus,
  });

  /// Maps a `/places/` API item to a MapPinInfo.
  factory MapPinInfo.fromApi(Map<String, dynamic> json) {
    final categoryJson = json['category'] as Map<String, dynamic>?;
    final placeType = json['place_type'] as String? ?? 'POI';
    final visitStatus = json['user_visit_status'] as String? ?? 'UNVISITED';
    final isBusinessOfMonth =
        json['is_business_of_the_month'] as bool? ?? false;
    final visited = visitStatus != 'UNVISITED';

    return MapPinInfo(
      id: json['id'].toString(),
      name: json['name'] as String? ?? '',
      level: 1,
      lat: double.tryParse(json['latitude'].toString()) ?? 0.0,
      lng: double.tryParse(json['longitude'].toString()) ?? 0.0,
      tag: _resolveTag(placeType: placeType, isFeatured: isBusinessOfMonth),
      visited: visited,
      category: (categoryJson?['name'] as String? ?? '').toUpperCase(),
      categorySlug: categoryJson?['slug'] as String?,
      address: json['address'] as String?,
      points: json['base_points'] as int?,
      accentColor: const Color(0xFFD4C4B0),
      imageUrl: json['cover_photo'] as String?,
      placeType: placeType,
      visitStatus: visitStatus,
    );
  }
  static MapPinTag _resolveTag({
    required String placeType,
    required bool isFeatured,
  }) {
    if (placeType == 'EVENT') return MapPinTag.sponsoredOrEvent;
    if (isFeatured) return MapPinTag.sponsoredOrEvent;
    if (placeType == 'BUSINESS') return MapPinTag.business;
    return MapPinTag.pointOfInterest;
  }
}