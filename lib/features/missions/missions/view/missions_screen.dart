import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/missions_controller.dart';
import '../repository/missions_repository.dart';
import 'widgets/mission_card.dart';
import 'widgets/missions_filter_chips.dart';
import 'widgets/missions_header.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionsController(MissionsRepositoryImpl()),
      child: const _MissionsView(),
    );
  }
}

class _MissionsView extends StatelessWidget {
  const _MissionsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MissionsController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              child: MissionsHeader(
                onAchievementsTap: () =>
                    controller.openAchievements(context),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: MissionsFilterChips(
                selected: controller.state.selectedFilter,
                onSelected: controller.selectFilter,
              ),
            ),
            SizedBox(height: 16.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                itemCount: controller.state.missions.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final mission = controller.state.missions[index];
                  return MissionCard(
                    mission: mission,
                    onTap: () => controller.openMissionDetails(context, mission.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
