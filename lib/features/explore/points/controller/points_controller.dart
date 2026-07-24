import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/points_args.dart';
import '../model/points_model.dart';
import '../repository/points_repository.dart';
import '../../share_card/model/share_card_args.dart';

class PointsController extends ChangeNotifier {
  final PointsRepository repo;
  final PointsArgs args;
  PointsModel state;

  PointsController(this.repo, this.args) : state = repo.load(args);

  void shareMoment(BuildContext context) {
    context.push(
      '/share_card',
      extra: ShareCardArgs(
        level: args.level ?? 1,
        points: args.totalPoints ?? 0,
        cityPercent: args.cityPercent ?? 0,
        mapMissionArgs: args.toMapMissionArgs(),
        placeId: args.locationId,
      ),
    );
  }

  void continueExploring(BuildContext context) {
    context.go('/map', extra: args.toMapMissionArgs());
  }
}