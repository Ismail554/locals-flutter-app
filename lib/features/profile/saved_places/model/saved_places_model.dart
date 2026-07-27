import 'package:flutter/material.dart';

class SavedPlace {
  final String id;
  final String category;
  final String name;
  final Color imageColor;
  final String? imageUrl;

  const SavedPlace({
    required this.id,
    required this.category,
    required this.name,
    required this.imageColor,
    this.imageUrl,
  });

  factory SavedPlace.fromApi(Map<String, dynamic> json) {
    final place = json['place'] as Map<String, dynamic>? ?? json;

    String? extractImageUrl(Map<String, dynamic> data) {
      final candidates = <String?>[
        data['cover_photo'] as String?,
        data['full_image_url'] as String?,
        data['image_url'] as String?,
        data['image'] as String?,
        (data['image'] as Map<String, dynamic>?)?['url'] as String?,
        (data['image'] as Map<String, dynamic>?)?['full_image_url'] as String?,
        (data['image'] as Map<String, dynamic>?)?['medium_url'] as String?,
        (data['cover'] as Map<String, dynamic>?)?['url'] as String?,
      ];

      for (final candidate in candidates) {
        if (candidate != null && candidate.trim().isNotEmpty) {
          return candidate;
        }
      }
      return null;
    }

    return SavedPlace(
      id: place['id'].toString(),
      category: (place['category']?['name'] as String? ?? 'PLACE')
          .toUpperCase(),
      name: place['name'] as String? ?? 'Unknown Place',
      imageColor: const Color(0xFFD4C4B0),
      imageUrl: extractImageUrl(place),
    );
  }
}

class SavedPlacesModel {
  final List<SavedPlace> places;

  const SavedPlacesModel({this.places = const []});
}
