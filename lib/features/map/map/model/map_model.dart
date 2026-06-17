import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import '../../filters/model/filters_model.dart';
import 'map_mission_args.dart';

class MapModel {
  final String searchQuery;
  final MapFiltersState filters;
  final bool hasUnreadNotifications;
  final List<MapPinInfo> pins;
  final String? selectedPinId;
  final MapActiveMission? activeMission;
  final MapActiveLocation? highlightedLocation;

  const MapModel({
    this.searchQuery = '',
    this.filters = MapFiltersState.defaults,
    this.hasUnreadNotifications = true,
    this.selectedPinId,
    this.activeMission,
    this.highlightedLocation,
    this.pins = const [
      MapPinInfo(
        id: 'cafe_del_born',
        name: 'Café del Born',
        level: 12,
        x: 0.22,
        y: 0.18,
        tag: MapPinTag.business,
        visited: true,
      ),
      MapPinInfo(
        id: 'parc_guell',
        name: 'Parc Güell',
        level: 8,
        x: 0.72,
        y: 0.14,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
      MapPinInfo(
        id: 'forn_baluard',
        name: 'Forn Baluard',
        level: 6,
        x: 0.48,
        y: 0.28,
        tag: MapPinTag.business,
        visited: false,
      ),
      MapPinInfo(
        id: 'la_merce_stop',
        name: 'La Mercè Route',
        level: 15,
        x: 0.35,
        y: 0.42,
        tag: MapPinTag.sponsoredOrEvent,
        visited: true,
      ),
      MapPinInfo(
        id: 'bar_marsella',
        name: 'Bar Marsella',
        level: 10,
        x: 0.62,
        y: 0.38,
        tag: MapPinTag.business,
        visited: true,
      ),
      MapPinInfo(
        id: 'sagrada',
        name: 'Sagrada Família',
        level: 18,
        x: 0.18,
        y: 0.55,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
      MapPinInfo(
        id: 'bunkers',
        name: 'Bunkers del Carmel',
        level: 9,
        x: 0.78,
        y: 0.52,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
      MapPinInfo(
        id: 'born_market',
        name: 'Mercat del Born',
        level: 5,
        x: 0.42,
        y: 0.62,
        tag: MapPinTag.business,
        visited: false,
      ),
      MapPinInfo(
        id: 'modernist_trail',
        name: 'Modernist Trail',
        level: 14,
        x: 0.58,
        y: 0.72,
        tag: MapPinTag.sponsoredOrEvent,
        visited: false,
      ),
      MapPinInfo(
        id: 'plaça_reial',
        name: 'Plaça Reial',
        level: 7,
        x: 0.28,
        y: 0.78,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
    ],
  });

  MapModel copyWith({
    String? searchQuery,
    MapFiltersState? filters,
    bool? hasUnreadNotifications,
    List<MapPinInfo>? pins,
    String? selectedPinId,
    bool clearSelectedPin = false,
    MapActiveMission? activeMission,
    bool clearMission = false,
    MapActiveLocation? highlightedLocation,
    bool clearHighlightedLocation = false,
  }) {
    return MapModel(
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      hasUnreadNotifications:
          hasUnreadNotifications ?? this.hasUnreadNotifications,
      pins: pins ?? this.pins,
      selectedPinId:
          clearSelectedPin ? null : selectedPinId ?? this.selectedPinId,
      activeMission:
          clearMission ? null : activeMission ?? this.activeMission,
      highlightedLocation: clearHighlightedLocation
          ? null
          : highlightedLocation ?? this.highlightedLocation,
    );
  }
}
