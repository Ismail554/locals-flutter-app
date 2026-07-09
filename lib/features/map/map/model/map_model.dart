import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import '../../filters/model/filters_model.dart';
import 'map_mission_args.dart';

class MapModel {
  final String searchQuery;
  final MapFiltersState filters;
  final bool hasUnreadNotifications;
  final List<MapPinInfo> pins;
  final bool isLoadingPins;
  final String? selectedPinId;
  final MapActiveMission? activeMission;
  final MapActiveLocation? highlightedLocation;
  final bool showRoute;
  final Set<Polyline> polylines;
  final List<MapActiveLocation>? routeStops;
  final LatLng? initialCenter;              
  final double? initialZoom;

  const MapModel({
    this.searchQuery = '',
    this.filters = MapFiltersState.defaults,
    this.hasUnreadNotifications = true,
    this.selectedPinId,
    this.activeMission,
    this.highlightedLocation,
    this.pins = const [],
    this.isLoadingPins = false,
    this.showRoute = false,
    this.polylines = const {},
    this.routeStops,
    this.initialCenter,
    this.initialZoom,
  });

  MapModel copyWith({
    String? searchQuery,
    MapFiltersState? filters,
    bool? hasUnreadNotifications,
    List<MapPinInfo>? pins,
    bool? isLoadingPins,
    String? selectedPinId,
    bool clearSelectedPin = false,
    MapActiveMission? activeMission,
    bool clearMission = false,
    MapActiveLocation? highlightedLocation,
    bool clearHighlightedLocation = false,
    bool? showRoute,
    Set<Polyline>? polylines,
  }) {
    return MapModel(
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      hasUnreadNotifications:
          hasUnreadNotifications ?? this.hasUnreadNotifications,
      pins: pins ?? this.pins,
      isLoadingPins: isLoadingPins ?? this.isLoadingPins,
      selectedPinId: clearSelectedPin
          ? null
          : selectedPinId ?? this.selectedPinId,
      activeMission: clearMission ? null : activeMission ?? this.activeMission,
      highlightedLocation: clearHighlightedLocation
          ? null
          : highlightedLocation ?? this.highlightedLocation,
      showRoute: showRoute ?? this.showRoute,
      polylines: polylines ?? this.polylines,
    );
  }

  MapPinInfo? getPinById(String id) {
    return pins.where((pin) => pin.id == id).firstOrNull;
  }
}
