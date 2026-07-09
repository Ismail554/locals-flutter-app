enum MissionStopStatus { completed, pending }

class MissionStop {
  final String placeId;
  final int number;
  final String name;
  final String category;
  final String address;
  final MissionStopStatus status;
  final double? latitude;
  final double? longitude;

  final String city;
  final String seal;

  const MissionStop({
    required this.placeId,
    required this.number,
    required this.name,
    required this.category,
    required this.address,
    required this.status,
    required this.city,
    required this.seal,
    this.latitude,
    this.longitude,
  });
}

class MissionDetailsModel {
  final String id;
  final String title;
  final String description;
  final int reward;
  final int totalStops;
  final String level;
  final int progressCurrent;
  final int progressTotal;
  final List<MissionStop> stops;

  const MissionDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reward,
    required this.totalStops,
    required this.level,
    required this.progressCurrent,
    required this.progressTotal,
    required this.stops,
  });

  double get progress =>
      progressTotal == 0 ? 0 : progressCurrent / progressTotal;

  factory MissionDetailsModel.empty() => const MissionDetailsModel(
        id: '',
        title: '',
        description: '',
        reward: 0,
        totalStops: 0,
        level: '',
        progressCurrent: 0,
        progressTotal: 0,
        stops: [],
      );
}