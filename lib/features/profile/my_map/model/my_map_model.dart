import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';

enum MyMapFilter { all, visited, unvisited }

class MyMapModel {
  final MyMapFilter selectedFilter;
  final List<MapPinInfo> pins;
  final String? selectedPinId;

  const MyMapModel({
    this.selectedFilter = MyMapFilter.all,
    this.selectedPinId,
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
    ],
  });

  int get visitedCount => pins.where((p) => p.visited).length;
  int get unvisitedCount => pins.where((p) => !p.visited).length;

  List<MapPinInfo> get filteredPins {
    return switch (selectedFilter) {
      MyMapFilter.all => pins,
      MyMapFilter.visited => pins.where((p) => p.visited).toList(),
      MyMapFilter.unvisited => pins.where((p) => !p.visited).toList(),
    };
  }

  MyMapModel copyWith({
    MyMapFilter? selectedFilter,
    String? selectedPinId,
    bool clearSelectedPin = false,
  }) {
    return MyMapModel(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedPinId:
          clearSelectedPin ? null : selectedPinId ?? this.selectedPinId,
      pins: pins,
    );
  }
}
