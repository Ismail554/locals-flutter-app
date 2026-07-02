import 'package:flutter/material.dart';
import 'package:locals/core/network/user_session.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';

class ShareCardArgs {
  final String cityLabel;
  final int level;
  final int points;
  final int cityPercent;
  final Color previewColor;
  final MapMissionArgs? mapMissionArgs;

  const ShareCardArgs({
    this.cityLabel = 'LOCAL · BARCELONA',
    this.level = 1,
    this.points = 0,
    this.cityPercent = 0,
    this.previewColor = const Color(0xFFEA4D70),
    this.mapMissionArgs,
  });

  factory ShareCardArgs.fromCurrentUser({
    String cityLabel = 'LOCAL · BARCELONA',
    Color previewColor = const Color(0xFFEA4D70),
    MapMissionArgs? mapMissionArgs,
  }) {
    final user = UserSession().currentUser;
    return ShareCardArgs(
      cityLabel: cityLabel,
      level: user?.level ?? 1,
      points: user?.totalPoints ?? 0,
      cityPercent: 0,
      previewColor: previewColor,
      mapMissionArgs: mapMissionArgs,
    );
  }
}