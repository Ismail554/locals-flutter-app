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
    this.pins = const [],
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
    List<MapPinInfo>? pins,
    bool clearSelectedPin = false,
  }) {
    return MyMapModel(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedPinId: clearSelectedPin ? null : (selectedPinId ?? this.selectedPinId),
      pins: pins ?? this.pins,
    );
  }
}