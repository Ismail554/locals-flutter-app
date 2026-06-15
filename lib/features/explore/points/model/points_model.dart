class PointsModel {
  final String locationName;
  final int points;
  final String cityName;
  final double cityProgress;

  const PointsModel({
    required this.locationName,
    required this.points,
    required this.cityName,
    required this.cityProgress,
  });

  String get cityProgressLabel =>
      '$cityName · ${(cityProgress * 100).round()}% complete';
}
