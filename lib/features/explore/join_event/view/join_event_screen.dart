import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/join_event_controller.dart';
import '../model/join_event_args.dart';
import '../repository/join_event_repository.dart';
import 'widgets/join_event_hero_header.dart';
import 'widgets/join_event_stats_row.dart';
import 'widgets/join_event_stop_tile.dart';

class JoinEventScreen extends StatelessWidget {
  final JoinEventArgs? args;

  const JoinEventScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final resolvedArgs = args ??
        (GoRouterState.of(context).extra as JoinEventArgs?);

    return ChangeNotifierProvider(
      create: (_) => JoinEventController(
        JoinEventRepositoryImpl(),
        resolvedArgs ?? const JoinEventArgs(eventId: 'la_merce'),
      ),
      child: const _JoinEventView(),
    );
  }
}

class _JoinEventView extends StatelessWidget {
  const _JoinEventView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<JoinEventController>();
    final event = controller.event;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JoinEventHeroHeader(
                      sponsor: event.sponsor,
                      title: event.title,
                      dateLabel: event.dateLabel,
                      heroColor: event.heroColor,
                      onBack: () => context.pop(),
                    ),
                    SizedBox(height: 20.h),
                    JoinEventStatsRow(
                      stops: '${event.totalStops}',
                      reward: '+${event.rewardPoints}',
                      progress: event.progressLabel,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'ROUTE STOPS',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    for (var i = 0; i < event.stops.length; i++) ...[
                      if (i > 0) SizedBox(height: 10.h),
                      JoinEventStopTile(
                        stop: event.stops[i],
                        onTap: event.stops[i].locationId != null
                            ? () => controller.openStop(
                                  context,
                                  event.stops[i],
                                )
                            : null,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: event.isJoined
                      ? null
                      : () => controller.joinEvent(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.actionPink,
                    disabledBackgroundColor:
                        AppColors.actionPink.withValues(alpha: 0.5),
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    event.isJoined ? 'Joined' : 'Join event',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
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
