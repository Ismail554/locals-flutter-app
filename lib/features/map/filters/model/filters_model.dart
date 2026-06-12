enum PlaceTypeFilter { businesses, herbs, both }

enum VisitStatusFilter { visited, unvisited, both }

class PlaceCategory {
  final String id;
  final String label;
  final String emoji;

  const PlaceCategory({
    required this.id,
    required this.label,
    required this.emoji,
  });
}

class MapFiltersState {
  final Set<String> selectedCategoryIds;
  final PlaceTypeFilter placeType;
  final VisitStatusFilter visitStatus;

  const MapFiltersState({
    required this.selectedCategoryIds,
    this.placeType = PlaceTypeFilter.both,
    this.visitStatus = VisitStatusFilter.unvisited,
  });

  static const categories = [
    PlaceCategory(id: 'restaurant', label: 'Restaurant', emoji: '🍽️'),
    PlaceCategory(id: 'bar', label: 'Bar', emoji: '🍷'),
    PlaceCategory(id: 'cafe', label: 'Cafe', emoji: '☕'),
    PlaceCategory(id: 'bakery', label: 'Bakery', emoji: '🥐'),
    PlaceCategory(id: 'shop', label: 'Shop', emoji: '🛍️'),
    PlaceCategory(id: 'market', label: 'Market', emoji: '🧺'),
    PlaceCategory(id: 'monument', label: 'Monument', emoji: '🏛️'),
    PlaceCategory(id: 'cultural', label: 'Cultural Space', emoji: '🎭'),
    PlaceCategory(id: 'viewpoint', label: 'Viewpoint', emoji: '🖼️'),
    PlaceCategory(id: 'square', label: 'Square', emoji: '🏙️'),
    PlaceCategory(id: 'other', label: 'Other', emoji: '📍'),
  ];

  static const defaults = MapFiltersState(
    selectedCategoryIds: {'bar', 'bakery', 'monument'},
    placeType: PlaceTypeFilter.both,
    visitStatus: VisitStatusFilter.unvisited,
  );

  static const cleared = MapFiltersState(
    selectedCategoryIds: {},
    placeType: PlaceTypeFilter.both,
    visitStatus: VisitStatusFilter.both,
  );

  MapFiltersState copyWith({
    Set<String>? selectedCategoryIds,
    PlaceTypeFilter? placeType,
    VisitStatusFilter? visitStatus,
  }) {
    return MapFiltersState(
      selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
      placeType: placeType ?? this.placeType,
      visitStatus: visitStatus ?? this.visitStatus,
    );
  }
}

class FiltersArgs {
  final MapFiltersState initial;
  final void Function(MapFiltersState filters) onApply;

  const FiltersArgs({
    required this.initial,
    required this.onApply,
  });
}
