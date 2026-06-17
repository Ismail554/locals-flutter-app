import 'map_mission_args.dart';

class MapScreenArgs {
  final String? focusedPinId;
  final MapActiveLocation? highlightedLocation;
  final MapMissionArgs? mission;

  const MapScreenArgs({
    this.focusedPinId,
    this.highlightedLocation,
    this.mission,
  });

  factory MapScreenArgs.fromExtra(Object? extra) {
    if (extra is MapScreenArgs) return extra;
    if (extra is MapMissionArgs) {
      return MapScreenArgs(
        mission: extra,
        focusedPinId: extra.activeLocation.mapPinId,
        highlightedLocation: extra.activeLocation,
      );
    }
    return const MapScreenArgs();
  }
}
