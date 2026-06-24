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
    lat: 23.8103,
    lng: 90.4125,
        tag: MapPinTag.business,
        visited: true,
      ),
      MapPinInfo(
        id: 'parc_guell',
        name: 'Parc Güell',
        level: 8,
    lat: 41.4145,
    lng: 2.1527,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
      MapPinInfo(
        id: 'forn_baluard',
        name: 'Forn Baluard',
        level: 6,
    lat: 41.3825,
    lng: 2.1769,
        tag: MapPinTag.business,
        visited: false,
      ),
      MapPinInfo(
        id: 'casa_batllo',
        name: 'Casa Batlló',
        level: 16,
    lat: 41.4036,
    lng: 2.1744,
        tag: MapPinTag.sponsoredOrEvent,
        visited: true,
      ),
      MapPinInfo(
        id: 'bar_marsella',
        name: 'Bar Marsella',
        level: 10,
    lat: 41.3809,
    lng: 2.1730,
        tag: MapPinTag.business,
        visited: true,
      ),
      MapPinInfo(
        id: 'sagrada',
        name: 'Sagrada Família',
        level: 18,
    lat: 41.3792,
    lng: 2.1649,
        tag: MapPinTag.pointOfInterest,
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
