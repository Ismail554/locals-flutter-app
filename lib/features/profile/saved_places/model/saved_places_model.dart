import 'package:flutter/material.dart';

class SavedPlace {
  final String id;
  final String category;
  final String name;
  final Color imageColor;

  const SavedPlace({
    required this.id,
    required this.category,
    required this.name,
    required this.imageColor,
  });

  factory SavedPlace.fromApi(Map<String, dynamic> json) {
    final place = json['place'] as Map<String, dynamic>? ?? json;

    return SavedPlace(
      id: place['id'].toString(),
      category: (place['category']?['name'] as String? ?? 'PLACE').toUpperCase(),
      name: place['name'] as String? ?? 'Unknown Place',
      imageColor: const Color(0xFFD4C4B0), 
    );
  }
}

class SavedPlacesModel {
  final List<SavedPlace> places;

  const SavedPlacesModel({
    this.places = const [],
  });
}