import 'package:flutter/material.dart';

class MapMissionArgs {
  final String city;
  final int completedCount;
  final int totalCount;
  final MapActiveLocation activeLocation;
  final String? eventId;

  const MapMissionArgs({
    required this.city,
    required this.completedCount,
    required this.totalCount,
    required this.activeLocation,
    this.eventId,
  });

  MapActiveMission toActiveMission() {
    return MapActiveMission(
      city: city,
      completedCount: completedCount,
      totalCount: totalCount,
      activeLocation: activeLocation,
      eventId: eventId,
    );
  }
}

class MapActiveMission {
  final String city;
  final int completedCount;
  final int totalCount;
  final MapActiveLocation activeLocation;
  final String? eventId;

  const MapActiveMission({
    required this.city,
    required this.completedCount,
    required this.totalCount,
    required this.activeLocation,
    this.eventId,
  });

  double get progress => completedCount / totalCount;

  int get percent => (progress * 100).round();
}

class MapActiveLocation {
  final String? locationId;
  final String category;
  final String seal;
  final String name;
  final String address;
  final int points;
  final Color imageColor;

  const MapActiveLocation({
    this.locationId,
    required this.category,
    required this.seal,
    required this.name,
    required this.address,
    required this.points,
    required this.imageColor,
  });

  String get resolvedLocationId =>
      locationId ?? locationIdForName(name) ?? 'cafe_del_born';

  String get mapPinId => mapPinIdForLocationId(locationId ?? locationIdForName(name));
}

const _locationIdsByName = <String, String>{
  'Café del Born': 'cafe_del_born',
  'Bar Marsella': 'bar_marsella',
  'Forn Baluard': 'forn_baluard',
  'Parc Güell': 'parc_guell',
};

String? locationIdForName(String name) => _locationIdsByName[name];

String mapPinIdForLocationId(String? locationId) {
  if (locationId == null) return 'cafe_del_born';
  return _locationIdsById[locationId] ?? locationId;
}

const _locationIdsById = <String, String>{
  'sagrada_familia': 'sagrada',
};
