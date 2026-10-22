import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/points_controller.dart';
import '../model/points_args.dart';
import '../repository/points_repository.dart';
import 'widgets/points_city_progress.dart';
import 'widgets/points_success_icon.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class PointsScreen extends StatelessWidget {
  final PointsArgs? args;

  const PointsScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final resolvedArgs =
        args ?? (GoRouterState.of(context).extra as PointsArgs?);

    assert(
      resolvedArgs != null,
      'PointsScreen requires PointsArgs to be passed via GoRouter extra.',
    );

    return ChangeNotifierProvider(
      create: (_) => PointsController(
        PointsRepositoryImpl(),
        resolvedArgs!,
      ),
      child: const _PointsView(),
    );
  }
}

class _PointsView extends StatelessWidget {
  const _PointsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PointsController>();
    final state = controller.state;

    final hasLevelInfo = state.level != null && state.totalPoints != null;

    return Scaffold(
      backgroundColor: AppColors.profileLevelCard,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const PointsSuccessIcon(),
              SizedBox(height: 24.h),
              Text(
                context.l10n.checkInConfirmed,
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.85),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                '+${state.points}',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 56.sp,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              Text(
                context.l10n.statPoints,
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.85),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              if (hasLevelInfo) ...[
                SizedBox(height: 12.h),
                Text(
                  'Level ${state.level} · ${state.totalPoints} total points',
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.7),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              SizedBox(height: 32.h),
              // Text(
              //   context.l10n.checkInLocationYours(state.locationName),
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: AppColors.white,
              //     fontSize: 22.sp,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // SizedBox(height: 8.h),
              Text(
                context.l10n.checkInAddedToMap,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.55),
                  fontSize: 15.sp,
                ),
              ),
              if (state.hasCityProgress) ...[
                SizedBox(height: 32.h),
                PointsCityProgress(
                  label: state.cityProgressLabel!,
                  progress: state.cityProgress!,
                ),
              ],
              if (state.unlockedAchievements.isNotEmpty) ...[
                SizedBox(height: 24.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  alignment: WrapAlignment.center,
                  children: state.unlockedAchievements
                      .map(
                        (achievement) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.actionPink.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.actionPink.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            achievement,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => controller.shareMoment(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.actionPink,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    context.l10n.checkInShareMoment,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => controller.continueExploring(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: BorderSide(
                      color: AppColors.white.withValues(alpha: 0.4),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    context.l10n.checkInContinueExploring,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}