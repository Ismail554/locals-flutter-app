/// Travel modes offered in the directions view.
///
/// [apiMode] maps each mode to the value expected by the Google Directions
/// API `mode` query parameter.
enum TravelMode {
  walk,
  car,
  bus;

  String get apiMode {
    switch (this) {
      case TravelMode.walk:
        return 'walking';
      case TravelMode.car:
        return 'driving';
      case TravelMode.bus:
        return 'transit';
    }
  }

  /// Safe lookup by [TravelMode.name] that falls back to [TravelMode.walk]
  /// for unknown / missing values (e.g. corrupt persisted state).
  static TravelMode fromName(String? name) {
    return TravelMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => TravelMode.walk,
    );
  }
}
