import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/mission_details_model.dart';
import 'mission_details_stop_tile.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class MissionDetailsStopsSection extends StatelessWidget {
  final List<MissionStop> stops;

  const MissionDetailsStopsSection({super.key, required this.stops});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.missionStopsSection,
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12.h),
        ...stops.map(
          (stop) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: MissionDetailsStopTile(stop: stop),
          ),
        ),
      ],
    );
  }
}
