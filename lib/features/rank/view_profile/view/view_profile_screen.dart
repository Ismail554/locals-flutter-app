import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/view_profile_controller.dart';
import '../model/view_profile_args.dart';
import '../model/view_profile_model.dart';
import '../repository/view_profile_repository.dart';
import 'widgets/view_profile_achievements_tab.dart';
import 'widgets/view_profile_action_buttons.dart';
import 'widgets/view_profile_header_section.dart';
import 'widgets/view_profile_map_tab.dart';
import 'widgets/view_profile_photos_tab.dart';
import 'widgets/view_profile_stats_row.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ViewProfileScreen extends StatelessWidget {
  final ViewProfileArgs? args;

  const ViewProfileScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    // Safe args resolution
    final resolvedArgs =
        args ?? (GoRouterState.of(context).extra as ViewProfileArgs?);

    return ChangeNotifierProvider(
      create: (_) => ViewProfileController(
        ViewProfileRepositoryImpl(),
        userId: resolvedArgs?.userId ?? '', // Safe fallback
      ),
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

    final bool isPhotosActive = state.selectedTab == ViewProfileTab.photos;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.viewProfileTitle(state.name ?? ''),
                onBack: () => context.pop(),
                onMorePressed: () => controller.showMoreOptions(context),
              ),
            ),
            SizedBox(height: 20.h),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                  child: Column(
                    children: [
                      ViewProfileHeaderSection(
                        name: state.name ?? '',
                        level: state.level ?? 1,
                        location: state.location ?? '',
                        avatarUrl: state.avatar,
                        hasStory: controller.hasStory,
                        isStoryViewed: controller.isStoryViewed,
                        onAvatarTap: () => controller.openStory(context),
                      ),

                      SizedBox(height: 20.h),

                      ViewProfileActionButtons(
                        isFollowing: state.isFollowing,
                        onFollowTap: controller.toggleFollow,
                        isPhotosActive: isPhotosActive,
                        onSecondaryButtonTap: () {
                          if (isPhotosActive) {
                            controller.selectTab(ViewProfileTab.map);
                          } else {
                            controller.selectTab(ViewProfileTab.photos);
                          }
                        },
                      ),

                      SizedBox(height: 16.h),

                      ViewProfileStatsRow(
                        visits: state.visits ?? 0,
                        followers: state.followers ?? 0,
                        likes: state.likes ?? 0,
                      ),

                      SizedBox(height: 20.h),

                      if (!isPhotosActive) ...[
                        ProfileSegmentedControl(
                          options: [
                            ProfileSegmentOption(
                              label: context.l10n.navMap,
                              value: 'map',
                            ),
                            ProfileSegmentOption(
                              label: context.l10n.achievementsTitle,
                              value: 'achievements',
                            ),
                          ],
                          selectedValue: state.selectedTab.name,
                          onChanged: (value) => controller.selectTab(
                            ViewProfileTab.values.byName(value),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],

                      // Tab Content
                      switch (state.selectedTab) {
                        ViewProfileTab.photos => ViewProfilePhotosTab(
                          photos: state.photos ?? [],
                          onPhotoTap: (photo) =>
                              controller.openPhoto(context, photo),
                        ),
                        ViewProfileTab.map => ViewProfileMapTab(
                          pins: state.mapPins ?? [],
                        ),
                        ViewProfileTab.achievements =>
                          ViewProfileAchievementsTab(
                            achievements: state.achievements ?? [],
                          ),
                      },
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
