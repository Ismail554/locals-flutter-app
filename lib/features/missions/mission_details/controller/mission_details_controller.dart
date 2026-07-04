import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';
import '../model/mission_details_model.dart';
import '../repository/mission_details_repository.dart';

class MissionDetailsController extends ChangeNotifier {
  final MissionDetailsRepository repo;
  MissionDetailsModel state;

  MissionDetailsController(this.repo, {String? missionId})
      : state = MissionDetailsModel.coffeeCartographer;

  void continueMission(BuildContext context) {
    context.go(
      '/map',
      extra: MapMissionArgs(
        city: 'Barcelona',
        completedCount: 5,
        totalCount: 35,
        activeLocation: MapActiveLocation(
          locationId: 'cafe_del_born',
          category: 'CAFE',
          seal: 'Seal',
          name: 'Café del Born',
          address: 'Carrer del Born 12',
          points: 50,
          imageColor: const Color(0xFFD4C4B0), 
          latitude: 41.3833, 
          longitude: 2.1833,
        ),
      ),
    );
  }
}
