class PointsModel {
  final String locationName;
  final int points; // points earned from this check-in

  // Nullable: only populated when PointsArgs came from a real check-in
  // response (PointsArgs.fromCheckIn). Screens must handle these being
  // absent for the "already visited" flow.
  final String? cityName;
  final double? cityProgress; // 0.0 - 1.0
  final int? level;
  final int? totalPoints;
  final bool missionCompleted;
  final List<String> unlockedAchievements;

  const PointsModel({
    required this.locationName,
    required this.points,
    this.cityName,
    this.cityProgress,
    this.level,
    this.totalPoints,
    this.missionCompleted = false,
    this.unlockedAchievements = const [],
  });

  bool get hasCityProgress => cityName != null && cityProgress != null;

  String? get cityProgressLabel => hasCityProgress
      ? '$cityName · ${(cityProgress! * 100).round()}% complete'
      : null;
}