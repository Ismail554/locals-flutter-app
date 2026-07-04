import 'package:flutter/material.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';

class PointsArgs {
  final String locationName;
  final int points;
  final String cityName;
  final double cityProgress;
  final int level;
  final int totalPoints;
  final int cityPercent;
  final int? completedCount;
  final int? totalCount;
  final String? locationCategory;
  final String? locationAddress;
  final Color? locationColor;
  final String? locationId;
  final String? eventId;

  const PointsArgs({
    required this.locationName,
    this.locationId,
    this.points = 50,
    this.cityName = 'Barcelona',
    this.cityProgress = 0.48,
    this.level = 12,
    this.totalPoints = 4380,
    this.cityPercent = 14,
    this.completedCount,
    this.totalCount,
    this.locationCategory,
    this.locationAddress,
    this.locationColor,
    this.eventId,
  });

  MapMissionArgs toMapMissionArgs() {
    final completed = completedCount ?? (cityProgress * 35).round().clamp(1, 35);
    final total = totalCount ?? 35;
    final meta = _locationMeta[locationName];

    return MapMissionArgs(
      city: cityName,
      completedCount: completed,
      totalCount: total,
      eventId: eventId,
      activeLocation: MapActiveLocation(
        locationId: locationId ?? _locationIds[locationName],
        category: locationCategory ?? meta?.$1 ?? 'LOCAL',
        seal: "locals' seal",
        name: locationName,
        address: locationAddress ?? meta?.$2 ?? '',
        points: points,
        imageColor: locationColor ?? meta?.$3 ?? const Color(0xFFD4C4B0), 
        latitude: locationName == 'Café del Born' ? 41.3833 : 0, 
        longitude: locationName == 'Café del Born' ? 2.1833 : 0,
      ),
    );
  }
}

const _locationIds = <String, String>{
  'Café del Born': 'cafe_del_born',
  'Bar Marsella': 'bar_marsella',
  'Forn Baluard': 'forn_baluard',
  'Parc Güell': 'parc_guell',
  'Sagrada Família': 'sagrada_familia',
  'Casa Batlló': 'cafe_del_born',
};

const _locationMeta = <String, (String, String, Color)>{
  'Café del Born': ('CAFE', 'Carrer del Born 12', Color(0xFFD4C4B0)),
  'Bar Marsella': ('BAR', 'Carrer de Sant Pau 65', Color(0xFFB8C8D8)),
  'Forn Baluard': ('BAKERY', 'Carrer del Baluard 38', Color(0xFFE8D8C8)),
  'Sagrada Família': ('MONUMENT', 'Carrer de Mallorca 401', Color(0xFFD0D8E0)),
  'Parc Güell': ('PARK', 'Carrer d\'Olot', Color(0xFFC8D8B8)),
  'Casa Batlló': ('MONUMENT', 'Passeig de Gràcia 43', Color(0xFF9A8A7A)),
};
