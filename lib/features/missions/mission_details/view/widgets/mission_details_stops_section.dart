import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/mission_details_model.dart';
import 'mission_details_stop_tile.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class MissionDetailsStopsSection extends StatelessWidget {
  final List<MissionStop> stops;
  final ValueChanged<MissionStop> onStopTap;

  const MissionDetailsStopsSection({
    super.key,
    required this.stops,
    required this.onStopTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stops.map((stop) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MissionDetailsStopTile(
            stop: stop,
            onTap: () => onStopTap(stop),
          ),
        );
      }).toList(),
    );
  }
}