enum MissionStopStatus { completed, pending }

class MissionStop {
  final int number;
  final String name;
  final String category;
  final String address;
  final MissionStopStatus status;

  const MissionStop({
    required this.number,
    required this.name,
    required this.category,
    required this.address,
    required this.status,
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

  double get progress => progressCurrent / progressTotal;

  static const coffeeCartographer = MissionDetailsModel(
    id: '1',
    title: 'Coffee Cartographer',
    description: 'Visit 5 traditional cafés in the Born neighborhood.',
    reward: 250,
    totalStops: 5,
    level: 'Easy',
    progressCurrent: 2,
    progressTotal: 7,
    stops: [
      MissionStop(
        number: 1,
        name: 'Café del Born',
        category: 'Cafe',
        address: 'Carrer del Born 12',
        status: MissionStopStatus.completed,
      ),
      MissionStop(
        number: 2,
        name: 'Origem Coffee',
        category: 'Cafe',
        address: 'Plaça de Sant Agustí 2',
        status: MissionStopStatus.completed,
      ),
      MissionStop(
        number: 3,
        name: 'Forn Baluard',
        category: 'Bakery',
        address: 'Carrer del Baluard 38',
        status: MissionStopStatus.pending,
      ),
      MissionStop(
        number: 4,
        name: 'Federal Café',
        category: 'Cafe',
        address: 'Carrer del Parlament 39',
        status: MissionStopStatus.pending,
      ),
      MissionStop(
        number: 5,
        name: "Satan's Coffee Corner",
        category: 'Cafe',
        address: "Carrer de l'Arc de Sant Ramon del Portell",
        status: MissionStopStatus.pending,
      ),
    ],
  );
}
