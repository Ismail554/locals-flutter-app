import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/events_progress_map_controller.dart';
import '../model/events_progress_map_args.dart';
import '../repository/events_progress_map_repository.dart';
import 'widgets/events_progress_bottom_panel.dart';

class EventsProgressMapScreen extends StatelessWidget {
  final EventsProgressMapArgs? args;

  const EventsProgressMapScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final resolvedArgs = args ??
        (GoRouterState.of(context).extra as EventsProgressMapArgs?);

    return ChangeNotifierProvider(
      create: (_) => EventsProgressMapController(
        EventsProgressMapRepositoryImpl(),
        resolvedArgs ?? const EventsProgressMapArgs(eventId: 'modernist_weekend'),
      ),
      child: const _EventsProgressMapView(),
    );
  }
}

class _EventsProgressMapView extends StatelessWidget {
  const _EventsProgressMapView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EventsProgressMapController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: state.title,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: EventsProgressMapView(state: state),
                ),
              ),
            ),
            EventsProgressBottomPanel(
              state: state,
              onCheckIn: () => controller.checkInNextStop(context),
            ),
          ],
        ),
      ),
    );
  }
}
