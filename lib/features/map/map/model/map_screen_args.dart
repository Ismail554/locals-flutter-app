import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_mission_args.dart';

class MapScreenArgs {
  final String? focusedPinId;
  final MapActiveLocation? highlightedLocation;
  final MapMissionArgs? mission;

  final bool showRoute;

  final List<MapActiveLocation>? routeStops; 
  final LatLng? initialCenter;              
  final double? initialZoom;

  const MapScreenArgs({
    this.focusedPinId,
    this.highlightedLocation,
    this.mission,
    this.showRoute = false,
    this.routeStops,
    this.initialCenter,
    this.initialZoom,
  });

  factory MapScreenArgs.fromExtra(Object? extra) {
    if (extra is MapScreenArgs) return extra;
    if (extra is MapMissionArgs) {
      return MapScreenArgs(
        mission: extra,
        focusedPinId: extra.activeLocation.mapPinId,
        highlightedLocation: extra.activeLocation,
        showRoute: true,
        initialCenter: LatLng(
        extra.activeLocation.latitude,
        extra.activeLocation.longitude,
      ),
      initialZoom: 15.8,
      );
    }
    return const MapScreenArgs();
  }
}
