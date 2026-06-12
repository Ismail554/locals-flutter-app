enum RankScope { city, country, global, followers }

enum RankPeriod { weekly, monthly, allTime }

class PodiumUser {
  final int rank;
  final String name;
  final int score;
  final bool isCrowned;

  const PodiumUser({
    required this.rank,
    required this.name,
    required this.score,
    this.isCrowned = false,
  });
}

class RankEntry {
  final int rank;
  final String name;
  final int level;
  final int score;
  final bool isCurrentUser;

  const RankEntry({
    required this.rank,
    required this.name,
    required this.level,
    required this.score,
    this.isCurrentUser = false,
  });
}

class RankModel {
  final RankScope selectedScope;
  final RankPeriod selectedPeriod;
  final List<PodiumUser> podium;
  final List<RankEntry> entries;

  const RankModel({
    this.selectedScope = RankScope.city,
    this.selectedPeriod = RankPeriod.weekly,
    this.podium = const [
      PodiumUser(rank: 2, name: 'Marc B.', score: 11280),
      PodiumUser(rank: 1, name: 'Marta', score: 12450, isCrowned: true),
      PodiumUser(rank: 3, name: 'Júlia P.', score: 10720),
    ],
    this.entries = const [
      RankEntry(rank: 4, name: 'Paul s.', level: 19, score: 9540),
      RankEntry(rank: 5, name: 'Núria T.', level: 18, score: 9100),
      RankEntry(rank: 6, name: 'You', level: 12, score: 6380, isCurrentUser: true),
      RankEntry(rank: 7, name: 'Pol', level: 11, score: 4380),
      RankEntry(rank: 8, name: 'Laia M.', level: 18, score: 3980),
      RankEntry(rank: 9, name: 'Ann F.', level: 18, score: 3540),
      RankEntry(rank: 10, name: 'Oriol C.', level: 18, score: 3320),
    ],
  });

  RankModel copyWith({
    RankScope? selectedScope,
    RankPeriod? selectedPeriod,
    List<PodiumUser>? podium,
    List<RankEntry>? entries,
  }) {
    return RankModel(
      selectedScope: selectedScope ?? this.selectedScope,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      podium: podium ?? this.podium,
      entries: entries ?? this.entries,
    );
  }
}
