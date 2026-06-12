import '../../filters/model/filters_model.dart';
import 'map_mission_args.dart';

enum MapPinType { red, greyStar, greyDot, darkStar }

class MapPinData {
  final double x;
  final double y;
  final MapPinType type;

  const MapPinData({
    required this.x,
    required this.y,
    required this.type,
  });
}

class MapModel {
  final String searchQuery;
  final MapFiltersState filters;
  final bool hasUnreadNotifications;
  final List<MapPinData> pins;
  final MapActiveMission? activeMission;

  const MapModel({
    this.searchQuery = '',
    this.filters = MapFiltersState.defaults,
    this.hasUnreadNotifications = true,
    this.activeMission,
    this.pins = const [
      MapPinData(x: 0.22, y: 0.18, type: MapPinType.red),
      MapPinData(x: 0.72, y: 0.14, type: MapPinType.greyStar),
      MapPinData(x: 0.48, y: 0.28, type: MapPinType.greyDot),
      MapPinData(x: 0.35, y: 0.42, type: MapPinType.darkStar),
      MapPinData(x: 0.62, y: 0.38, type: MapPinType.red),
      MapPinData(x: 0.18, y: 0.55, type: MapPinType.greyStar),
      MapPinData(x: 0.78, y: 0.52, type: MapPinType.greyStar),
      MapPinData(x: 0.42, y: 0.62, type: MapPinType.greyDot),
      MapPinData(x: 0.58, y: 0.72, type: MapPinType.darkStar),
      MapPinData(x: 0.28, y: 0.78, type: MapPinType.greyStar),
    ],
  });

  MapModel copyWith({
    String? searchQuery,
    MapFiltersState? filters,
    bool? hasUnreadNotifications,
    List<MapPinData>? pins,
    MapActiveMission? activeMission,
    bool clearMission = false,
  }) {
    return MapModel(
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      hasUnreadNotifications:
          hasUnreadNotifications ?? this.hasUnreadNotifications,
      pins: pins ?? this.pins,
      activeMission:
          clearMission ? null : activeMission ?? this.activeMission,
    );
  }
}
