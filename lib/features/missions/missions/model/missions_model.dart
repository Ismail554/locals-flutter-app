enum MissionFilter { nearby, active, completed, events }

class MissionItem {
  final String id;
  final String title;
  final String description;
  final int points;
  final String difficulty;
  final String distance;
  final int currentProgress;
  final int totalProgress;

  const MissionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.difficulty,
    required this.distance,
    required this.currentProgress,
    required this.totalProgress,
  });

  double get progress =>
      totalProgress == 0 ? 0 : currentProgress / totalProgress;
}

class MissionsModel {
  final MissionFilter selectedFilter;
  final List<MissionItem> missions;

  const MissionsModel({
    this.selectedFilter = MissionFilter.nearby,
    this.missions = const [],
  });

  MissionsModel copyWith({
    MissionFilter? selectedFilter,
    List<MissionItem>? missions,
  }) {
    return MissionsModel(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      missions: missions ?? this.missions,
    );
  }
}