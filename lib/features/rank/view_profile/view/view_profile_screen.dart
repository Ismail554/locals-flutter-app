import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/view_profile_controller.dart';
import '../model/view_profile_model.dart';
import '../repository/view_profile_repository.dart';
import 'widgets/view_profile_achievements_tab.dart';
import 'widgets/view_profile_action_buttons.dart';
import 'widgets/view_profile_header_section.dart';
import 'widgets/view_profile_map_tab.dart';
import 'widgets/view_profile_photos_tab.dart';
import 'widgets/view_profile_stats_row.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ViewProfileController(ViewProfileRepositoryImpl()),
      child: const _ViewProfileView(),
    );
  }
}

class _ViewProfileView extends StatelessWidget {
  const _ViewProfileView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ViewProfileController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: "${state.name}'s profile",
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                child: Column(
                  children: [
                    ViewProfileHeaderSection(
                      name: state.name,
                      level: state.level,
                      location: state.location,
                      hasStory: state.hasStory,
                    ),
                    SizedBox(height: 20.h),
                    ViewProfileActionButtons(
                      isFollowing: state.isFollowing,
                      onFollowTap: controller.toggleFollow,
                      onBlockTap: () => controller.blockUser(context),
                    ),
                    SizedBox(height: 16.h),
                    ViewProfileStatsRow(
                      visits: state.visits,
                      pointsLabel: state.pointsLabel,
                      cities: state.cities,
                    ),
                    SizedBox(height: 20.h),
                    ProfileSegmentedControl(
                      options: const [
                        ProfileSegmentOption(
                          label: 'Photos',
                          value: 'photos',
                        ),
                        ProfileSegmentOption(
                          label: 'Map',
                          value: 'map',
                        ),
                        ProfileSegmentOption(
                          label: 'Achievements',
                          value: 'achievements',
                        ),
                      ],
                      selectedValue: state.selectedTab.name,
                      onChanged: (value) => controller.selectTab(
                        ViewProfileTab.values.byName(value),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    switch (state.selectedTab) {
                      ViewProfileTab.photos => ViewProfilePhotosTab(
                          photoColors: state.photoColors,
                        ),
                      ViewProfileTab.map => ViewProfileMapTab(
                          pins: state.mapPins,
                        ),
                      ViewProfileTab.achievements =>
                        ViewProfileAchievementsTab(
                          achievements: state.achievements,
                        ),
                    },
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
