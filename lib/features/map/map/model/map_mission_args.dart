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

  /// Guarded against totalCount == 0 (would otherwise be 0/0 = NaN).
  double get progress => totalCount <= 0 ? 0.0 : completedCount / totalCount;

  /// Guarded against NaN/Infinity (e.g. from totalCount == 0) — `.round()`
  /// throws an UnsupportedError on those values. Also clamps to a sane
  /// 0-100 range in case completedCount ever exceeds totalCount.
  int get percent {
    final value = progress * 100;
    if (!value.isFinite) return 0;
    return value.round().clamp(0, 100);
  }
}

class MapActiveLocation {
  final String? locationId;
  final String category;
  final String seal;
  final String name;
  final String address;
  final int points;
  final Color imageColor;
  final String? imageUrl;
  final double latitude;
  final double longitude;

  const MapActiveLocation({
    this.locationId,
    required this.category,
    required this.seal,
    required this.name,
    required this.address,
    required this.points,
    required this.imageColor,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  String get resolvedLocationId => locationId ?? locationIdForName(name) ?? '';

  String get mapPinId =>
      mapPinIdForLocationId(locationId ?? locationIdForName(name));
}

const _locationIdsByName = <String, String>{
  'Café del Born': 'cafe_del_born',
  'Bar Marsella': 'bar_marsella',
  'Forn Baluard': 'forn_baluard',
  'Parc Güell': 'parc_guell',
};

String? locationIdForName(String name) => _locationIdsByName[name];

String mapPinIdForLocationId(String? locationId) {
  if (locationId == null) return '';
  return _locationIdsById[locationId] ?? locationId;
}

const _locationIdsById = <String, String>{'sagrada_familia': 'sagrada'};
