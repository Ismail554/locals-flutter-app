import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/achievements_controller.dart';
import '../repository/achievements_repository.dart';
import 'widgets/achievement_grid_card.dart';
import 'widgets/achievements_progress_card.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AchievementsController(AchievementsRepositoryImpl()),
      child: const _AchievementsView(),
    );
  }
}

class _AchievementsView extends StatelessWidget {
  const _AchievementsView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AchievementsController>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Achievements',
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
                    AchievementsProgressCard(
                      unlockedCount: state.unlockedCount,
                      totalCount: state.totalCount,
                    ),
                    SizedBox(height: 16.h),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth =
                            (constraints.maxWidth - 12.w) / 2;
                        return Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: [
                            for (final achievement in state.achievements)
                              SizedBox(
                                width: cardWidth,
                                child: AchievementGridCard(
                                  achievement: achievement,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
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
