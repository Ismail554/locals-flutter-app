import 'package:flutter/material.dart';

class JoinEventRouteStop {
  final int number;
  final String name;
  final String category;
  final Color thumbnailColor;
  final String? locationId;

  const JoinEventRouteStop({
    required this.number,
    required this.name,
    required this.category,
    required this.thumbnailColor,
    this.locationId,
  });
}

class JoinEventModel {
  final String id;
  final String sponsor;
  final String title;
  final String dateLabel;
  final Color heroColor;
  final int totalStops;
  final int rewardPoints;
  final int progressCurrent;
  final List<JoinEventRouteStop> stops;
  final bool isJoined;

  const JoinEventModel({
    required this.id,
    required this.sponsor,
    required this.title,
    required this.dateLabel,
    required this.heroColor,
    required this.totalStops,
    required this.rewardPoints,
    required this.progressCurrent,
    required this.stops,
    this.isJoined = false,
  });

  String get progressLabel => '$progressCurrent/$totalStops';

  JoinEventModel copyWith({bool? isJoined, int? progressCurrent}) {
    return JoinEventModel(
      id: id,
      sponsor: sponsor,
      title: title,
      dateLabel: dateLabel,
      heroColor: heroColor,
      totalStops: totalStops,
      rewardPoints: rewardPoints,
      progressCurrent: progressCurrent ?? this.progressCurrent,
      stops: stops,
      isJoined: isJoined ?? this.isJoined,
    );
  }

  static const _laMerceStops = [
    JoinEventRouteStop(
      number: 1,
      name: 'Café del Born',
      category: 'Cafe',
      thumbnailColor: Color(0xFFD4C4B0),
      locationId: 'cafe_del_born',
    ),
    JoinEventRouteStop(
      number: 2,
      name: 'Bar Marsella',
      category: 'Bar',
      thumbnailColor: Color(0xFFB8C8D8),
      locationId: 'bar_marsella',
    ),
    JoinEventRouteStop(
      number: 3,
      name: 'Forn Baluard',
      category: 'Bakery',
      thumbnailColor: Color(0xFFE8D8C8),
      locationId: 'forn_baluard',
    ),
    JoinEventRouteStop(
      number: 4,
      name: 'Sagrada Família',
      category: 'Monument',
      thumbnailColor: Color(0xFFD0D8E0),
    ),
    JoinEventRouteStop(
      number: 5,
      name: 'Bunkers del Carmel',
      category: 'Viewpoint',
      thumbnailColor: Color(0xFFC8D8B8),
    ),
    JoinEventRouteStop(
      number: 6,
      name: 'Plaça Reial',
      category: 'Square',
      thumbnailColor: Color(0xFFB8A898),
    ),
  ];

  static const _laMerce = JoinEventModel(
    id: 'la_merce',
    sponsor: 'Ajuntament de Barcelona',
    title: 'La Mercè',
    dateLabel: 'SEP 22 - 25',
    heroColor: Color(0xFF4A6A8A),
    totalStops: 12,
    rewardPoints: 1500,
    progressCurrent: 0,
    stops: _laMerceStops,
  );

  static const _tapasRoute = JoinEventModel(
    id: 'tapas_route',
    sponsor: 'Estrella Damm',
    title: 'Tapas Route',
    dateLabel: 'ONGOING',
    heroColor: Color(0xFF8A7A6A),
    totalStops: 8,
    rewardPoints: 800,
    progressCurrent: 2,
    stops: [
      JoinEventRouteStop(
        number: 1,
        name: 'Bar Marsella',
        category: 'Bar',
        thumbnailColor: Color(0xFFB8C8D8),
        locationId: 'bar_marsella',
      ),
      JoinEventRouteStop(
        number: 2,
        name: 'Café del Born',
        category: 'Cafe',
        thumbnailColor: Color(0xFFD4C4B0),
        locationId: 'cafe_del_born',
      ),
      JoinEventRouteStop(
        number: 3,
        name: 'Forn Baluard',
        category: 'Bakery',
        thumbnailColor: Color(0xFFE8D8C8),
        locationId: 'forn_baluard',
      ),
    ],
  );

  static const _modernistWeekend = JoinEventModel(
    id: 'modernist_weekend',
    sponsor: 'Casa Batlló',
    title: 'Modernist Weekend',
    dateLabel: 'OCT 12 - 13',
    heroColor: Color(0xFF7A8A9A),
    totalStops: 7,
    rewardPoints: 600,
    progressCurrent: 0,
    stops: [
      JoinEventRouteStop(
        number: 1,
        name: 'Casa Batlló',
        category: 'Monument',
        thumbnailColor: Color(0xFF9A8A7A),
      ),
      JoinEventRouteStop(
        number: 2,
        name: 'Sagrada Família',
        category: 'Monument',
        thumbnailColor: Color(0xFFD0D8E0),
      ),
      JoinEventRouteStop(
        number: 3,
        name: 'Parc Güell',
        category: 'Park',
        thumbnailColor: Color(0xFFC8D8B8),
        locationId: 'parc_guell',
      ),
    ],
  );

  static JoinEventModel byId(String id) {
    return switch (id) {
      'la_merce' => _laMerce,
      'tapas_route' => _tapasRoute,
      'modernist_weekend' => _modernistWeekend,
      _ => _laMerce,
    };
  }
}
