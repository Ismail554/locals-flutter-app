import 'package:flutter/material.dart';
import '../../explore/model/explore_model.dart';

class FeaturedLocationsModel {
  final List<ExploreFeaturedLocation> locations;

  const FeaturedLocationsModel({
    this.locations = const [
      ExploreFeaturedLocation(
        id: 'cafe_del_born',
        category: 'CAFE',
        name: 'Café del Born',
        points: 50,
        imageColor: Color(0xFFD4C4B0),
      ),
      ExploreFeaturedLocation(
        id: 'bar_marsella',
        category: 'BAR',
        name: 'Bar Marsella',
        points: 40,
        imageColor: Color(0xFFB8C8D8),
      ),
      ExploreFeaturedLocation(
        id: 'forn_baluard',
        category: 'BAKERY',
        name: 'Forn Baluard',
        points: 60,
        imageColor: Color(0xFFE8D8C8),
      ),
      ExploreFeaturedLocation(
        id: 'parc_guell',
        category: 'PARK',
        name: 'Parc Güell',
        points: 60,
        imageColor: Color(0xFFC8D8B8),
      ),
    ],
  });
}
