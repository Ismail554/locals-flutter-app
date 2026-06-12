import 'package:flutter/material.dart';

class MapMissionArgs {
  final String city;
  final int completedCount;
  final int totalCount;
  final MapActiveLocation activeLocation;

  const MapMissionArgs({
    required this.city,
    required this.completedCount,
    required this.totalCount,
    required this.activeLocation,
  });

  MapActiveMission toActiveMission() {
    return MapActiveMission(
      city: city,
      completedCount: completedCount,
      totalCount: totalCount,
      activeLocation: activeLocation,
    );
  }
}

class MapActiveMission {
  final String city;
  final int completedCount;
  final int totalCount;
  final MapActiveLocation activeLocation;

  const MapActiveMission({
    required this.city,
    required this.completedCount,
    required this.totalCount,
    required this.activeLocation,
  });

  double get progress => completedCount / totalCount;

  int get percent => (progress * 100).round();
}

class MapActiveLocation {
  final String category;
  final String seal;
  final String name;
  final String address;
  final int points;
  final Color imageColor;

  const MapActiveLocation({
    required this.category,
    required this.seal,
    required this.name,
    required this.address,
    required this.points,
    required this.imageColor,
  });
}
