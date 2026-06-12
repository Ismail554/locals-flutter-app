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

  double get progress => currentProgress / totalProgress;
}

class MissionsModel {
  final MissionFilter selectedFilter;
  final List<MissionItem> missions;

  const MissionsModel({
    this.selectedFilter = MissionFilter.nearby,
    this.missions = const [
      MissionItem(
        id: '1',
        title: 'Coffee Cartographer',
        description: 'Visit 5 traditional cafés in the Born neighborhood.',
        points: 250,
        difficulty: 'EASY',
        distance: '0.8 Km',
        currentProgress: 3,
        totalProgress: 5,
      ),
      MissionItem(
        id: '2',
        title: 'Modernist Trail',
        description: 'Discover 7 modernist buildings in Eixample.',
        points: 500,
        difficulty: 'MEDIUM',
        distance: '1.2 Km',
        currentProgress: 2,
        totalProgress: 7,
      ),
    ],
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
