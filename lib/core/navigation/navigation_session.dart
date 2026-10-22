import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:locals/features/map/map/model/map_mission_args.dart';
import 'package:locals/features/map/map/model/travel_mode.dart';

/// A snapshot of an in-progress direction, so it can be resumed after the app
/// is killed and reopened — the same way Uber, Pathao or Google Maps bring you
/// back to the route you had open.
class NavigationSnapshot {
  final MapActiveLocation destination;
  final TravelMode travelMode;

  const NavigationSnapshot({
    required this.destination,
    required this.travelMode,
  });
}

/// Persists the currently active direction to disk (SharedPreferences).
///
/// Mirrors [TokenManager]'s singleton style so it can be reached from anywhere
/// without wiring it through the widget tree.
class NavigationSession {
  static final NavigationSession _instance = NavigationSession._internal();

  factory NavigationSession() => _instance;

  NavigationSession._internal();

  static const String _key = 'active_navigation';

  SharedPreferences? _prefs;

  Future<void> _ensure() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Stores [destination] + [travelMode] as the active direction, replacing
  /// any previously saved one.
  Future<void> save({
    required MapActiveLocation destination,
    required TravelMode travelMode,
  }) async {
    await _ensure();

    final payload = <String, dynamic>{
      'locationId': destination.locationId,
      'category': destination.category,
      'seal': destination.seal,
      'name': destination.name,
      'address': destination.address,
      'points': destination.points,
      'imageColor': destination.imageColor.toARGB32(),
      'imageUrl': destination.imageUrl,
      'latitude': destination.latitude,
      'longitude': destination.longitude,
      'travelMode': travelMode.name,
    };

    await _prefs?.setString(_key, jsonEncode(payload));
  }

  /// Returns the saved direction, or null if none is stored / it is unreadable.
  Future<NavigationSnapshot?> load() async {
    await _ensure();

    final raw = _prefs?.getString(_key);
    if (raw == null || raw.isEmpty) return null;

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;

      final lat = (map['latitude'] as num?)?.toDouble();
      final lng = (map['longitude'] as num?)?.toDouble();
      if (lat == null || lng == null) return null;

      final destination = MapActiveLocation(
        locationId: map['locationId'] as String?,
        category: map['category'] as String? ?? 'PLACE',
        seal: map['seal'] as String? ?? '',
        name: map['name'] as String? ?? '',
        address: map['address'] as String? ?? '',
        points: (map['points'] as num?)?.toInt() ?? 0,
        imageColor: Color(
          (map['imageColor'] as num?)?.toInt() ?? 0xFFD4C4B0,
        ),
        imageUrl: map['imageUrl'] as String?,
        latitude: lat,
        longitude: lng,
      );

      return NavigationSnapshot(
        destination: destination,
        travelMode: TravelMode.fromName(map['travelMode'] as String?),
      );
    } catch (_) {
      // Corrupt payload — drop it so we don't keep failing on every launch.
      await clear();
      return null;
    }
  }

  Future<void> clear() async {
    await _ensure();
    await _prefs?.remove(_key);
  }
}
