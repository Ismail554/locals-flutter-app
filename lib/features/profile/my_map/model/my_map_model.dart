import 'package:locals/features/map/map/model/map_model.dart';

enum MyMapFilter { all, visited, unvisited }

class MyMapPin {
  final double x;
  final double y;
  final MapPinType type;
  final bool visited;

  const MyMapPin({
    required this.x,
    required this.y,
    required this.type,
    required this.visited,
  });
}

class MyMapModel {
  final MyMapFilter selectedFilter;
  final List<MyMapPin> pins;

  const MyMapModel({
    this.selectedFilter = MyMapFilter.all,
    this.pins = const [
      MyMapPin(x: 0.22, y: 0.18, type: MapPinType.red, visited: true),
      MyMapPin(x: 0.72, y: 0.14, type: MapPinType.greyStar, visited: false),
      MyMapPin(x: 0.48, y: 0.28, type: MapPinType.greyDot, visited: false),
      MyMapPin(x: 0.35, y: 0.42, type: MapPinType.darkStar, visited: true),
      MyMapPin(x: 0.62, y: 0.38, type: MapPinType.red, visited: true),
      MyMapPin(x: 0.18, y: 0.55, type: MapPinType.greyStar, visited: false),
      MyMapPin(x: 0.78, y: 0.52, type: MapPinType.greyStar, visited: false),
      MyMapPin(x: 0.42, y: 0.62, type: MapPinType.greyDot, visited: false),
      MyMapPin(x: 0.58, y: 0.72, type: MapPinType.darkStar, visited: false),
    ],
  });

  int get visitedCount => pins.where((p) => p.visited).length;
  int get unvisitedCount => pins.where((p) => !p.visited).length;

  List<MyMapPin> get filteredPins {
    return switch (selectedFilter) {
      MyMapFilter.all => pins,
      MyMapFilter.visited => pins.where((p) => p.visited).toList(),
      MyMapFilter.unvisited => pins.where((p) => !p.visited).toList(),
    };
  }

  MyMapModel copyWith({MyMapFilter? selectedFilter}) {
    return MyMapModel(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      pins: pins,
    );
  }
}
