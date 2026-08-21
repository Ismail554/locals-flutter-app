import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/mission_details_controller.dart';
import '../repository/mission_details_repository.dart';
import 'widgets/mission_details_back_button.dart';
import 'widgets/mission_details_continue_button.dart';
import 'widgets/mission_details_header_card.dart';
import 'widgets/mission_details_progress_section.dart';
import 'widgets/mission_details_stops_section.dart';

class MissionDetailsScreen extends StatelessWidget {
  final String? missionId;

  const MissionDetailsScreen({super.key, this.missionId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionDetailsController(
        MissionDetailsRepositoryImpl(),
        missionId: missionId,
      ),
      child: const _MissionDetailsView(),
    );
  }
}

class _MissionDetailsView extends StatelessWidget {
  const _MissionDetailsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MissionDetailsController>();
    final mission = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: MissionDetailsBackButton(onTap: () => context.pop()),
              ),
            ),
            SizedBox(height: 16.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MissionDetailsHeaderCard(mission: mission),
                      SizedBox(height: 24.h),
                      MissionDetailsProgressSection(
                        current: mission.progressCurrent,
                        total: mission.progressTotal,
                        progress: mission.progress,
                      ),
                      SizedBox(height: 24.h),
                      MissionDetailsStopsSection(
                        stops: mission.stops,
                        onStopTap: (stop) => controller.openStop(context, stop),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: MissionDetailsContinueButton(
                onPressed: () => controller.continueMission(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
