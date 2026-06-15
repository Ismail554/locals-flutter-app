import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/explore_controller.dart';
import '../repository/explore_repository.dart';
import 'widgets/explore_featured_locations_section.dart';
import 'widgets/explore_featured_routes_section.dart';
import 'widgets/explore_follow_locals_section.dart';
import 'widgets/explore_header.dart';
import 'widgets/explore_new_locals_section.dart';
import 'widgets/explore_recent_activity_section.dart';
import 'widgets/explore_weekly_ranking_section.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreController(ExploreRepositoryImpl.instance),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExploreController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExploreHeader(
                onNotificationTap: () =>
                    controller.openNotifications(context),
              ),
              SizedBox(height: 20.h),
              ExploreRecentActivitySection(
                stories: state.stories,
                onStoryTap: (index) => controller.onStoryTap(context, index),
              ),
              SizedBox(height: 24.h),
              ExploreWeeklyRankingSection(
                users: state.weeklyRanking,
                onSeeAll: () => context.push('/rank'),
              ),
              SizedBox(height: 24.h),
              ExploreFollowLocalsSection(
                users: state.followLocals,
                stories: state.stories,
                onFollowTap: controller.toggleFollow,
                onCardTap: () => controller.openProfile(context),
                onAvatarTap: (id) => controller.openUserStory(context, id),
                onSeeAll: () => controller.openFindLocals(context),
              ),
              SizedBox(height: 24.h),
              ExploreFeaturedLocationsSection(
                locations: state.featuredLocations,
                onSeeAll: () => controller.openFeaturedLocations(context),
                onLocationTap: (id) =>
                    controller.openLocationDetails(context, id),
              ),
              SizedBox(height: 24.h),
              ExploreNewLocalsSection(locals: state.newLocals),
              SizedBox(height: 24.h),
              ExploreFeaturedRoutesSection(
                route: state.featuredRoute,
                onAllEvents: () => controller.openEventsRoutes(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
