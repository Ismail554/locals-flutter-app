import 'package:flutter/material.dart';
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
    lat: 23.8103,
    lng: 90.4125,
        tag: MapPinTag.business,
        visited: true,
        category: 'CAFE',
        address: 'Carrer del Born 12',
        points: 50,
        accentColor: Color(0xFFD4C4B0),
      ),
      MapPinInfo(
        id: 'parc_guell',
        name: 'Parc Güell',
        level: 8,
    lat: 41.4145,
    lng: 2.1527,
        tag: MapPinTag.pointOfInterest,
        visited: false,
        category: 'PARK',
        address: 'Carrer d\'Olot',
        points: 60,
        accentColor: Color(0xFFC8D8B8),
      ),
      MapPinInfo(
        id: 'forn_baluard',
        name: 'Forn Baluard',
        level: 6,
    lat: 41.3825,
    lng: 2.1769,
        tag: MapPinTag.business,
        visited: false,
        category: 'BAKERY',
        address: 'Carrer del Baluard 38',
        points: 30,
        accentColor: Color(0xFFE8D8C8),
      ),
      MapPinInfo(
        id: 'la_merce_stop',
        name: 'La Mercè Route',
        level: 15,
    lat: 41.3809,
    lng: 2.1730,
        tag: MapPinTag.sponsoredOrEvent,
        visited: true,
        category: 'EVENT',
        address: 'Basílica de la Mercè',
        points: 80,
        accentColor: Color(0xFFFFB6C1),
      ),
      MapPinInfo(
        id: 'bar_marsella',
        name: 'Bar Marsella',
        level: 10,
    lat: 41.3792,
    lng: 2.1649,
        tag: MapPinTag.business,
        visited: true,
        category: 'BAR',
        address: 'Carrer de Sant Pau 65',
        points: 40,
        accentColor: Color(0xFFB8C8D8),
      ),
      MapPinInfo(
        id: 'sagrada',
        name: 'Sagrada Família',
        level: 18,
    lat: 41.3854,
    lng: 2.1837,
        tag: MapPinTag.pointOfInterest,
        visited: false,
        category: 'MONUMENT',
        address: 'Carrer de Mallorca 401',
        points: 75,
        accentColor: Color(0xFFD0D8E0),
      ),
      MapPinInfo(
        id: 'bunkers',
        name: 'Bunkers del Carmel',
        level: 9,
    lat: 41.4036,
    lng: 2.1744,
        tag: MapPinTag.pointOfInterest,
        visited: false,
        category: 'VIEWPOINT',
        address: 'Carrer de Marià Labèrnia',
        points: 45,
        accentColor: Color(0xFF9DB2C8),
      ),
      MapPinInfo(
        id: 'born_market',
        name: 'Mercat del Born',
        level: 5,
    lat: 41.4177,
    lng: 2.1639,
        tag: MapPinTag.business,
        visited: false,
        category: 'MARKET',
        address: 'Plaça Comercial 12',
        points: 35,
        accentColor: Color(0xFFE8D8C8),
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

  // Helper method to fix 'getPinById' error
  MapPinInfo? getPinById(String id) {
    return pins.where((pin) => pin.id == id).firstOrNull;
  }
}