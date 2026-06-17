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
}

class SavedPlacesModel {
  final List<SavedPlace> places;

  const SavedPlacesModel({
    this.places = const [
      SavedPlace(
        id: 'cafe_del_born',
        category: 'CAFE',
        name: 'Café del Born',
        imageColor: Color(0xFFD4C4B0),
      ),
      SavedPlace(
        id: 'forn_baluard',
        category: 'BAKERY',
        name: 'Forn Baluard',
        imageColor: Color(0xFFE8D8C8),
      ),
    ],
  });
}
