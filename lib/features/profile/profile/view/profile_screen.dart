import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/profile_controller.dart';
import '../repository/profile_repository.dart';
import 'widgets/profile_achievements_section.dart';
import 'widgets/profile_action_grid.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_latest_visits_section.dart';
import 'widgets/profile_level_card.dart';
import 'widgets/profile_stats_row.dart';
import 'widgets/profile_top_actions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(ProfileRepositoryImpl()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
    final profile = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          child: Column(
            children: [
              ProfileTopActions(
                onShare: () => controller.shareProfile(context),
                onSettings: () => controller.openSettings(context),
              ),
              SizedBox(height: 16.h),
              ProfileHeader(name: profile.name, location: profile.location),
              SizedBox(height: 20.h),
              ProfileLevelCard(
                level: profile.level,
                points: profile.points,
                levelTitle: profile.levelTitle,
                pointsToNextLevel: profile.pointsToNextLevel,
              ),
              SizedBox(height: 16.h),
              ProfileStatsRow(
                visits: profile.visitCount,
                cities: profile.cities,
                followers: profile.followers,
              ),
              SizedBox(height: 16.h),
              ProfileActionGrid(
                onMyMap: () => controller.openMyMap(context),
                onFollowers: () => controller.openFollowersList(context),
                onSavedPlace: () => controller.openSavedPlaces(context),
                onBlocked: () => controller.openBlockedList(context),
              ),
              SizedBox(height: 24.h),
              ProfileAchievementsSection(achievements: profile.achievements),
              SizedBox(height: 24.h),
              ProfileLatestVisitsSection(visits: profile.latestVisits),
            ],
          ),
        ),
      ),
    );
  }
}
