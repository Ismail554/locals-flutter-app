import 'package:flutter/material.dart';
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
    this.level = 12,
    this.points = 4380,
    this.cityPercent = 14,
    this.previewColor = const Color(0xFFEA4D70),
    this.mapMissionArgs,
  });
}
