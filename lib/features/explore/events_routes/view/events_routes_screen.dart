import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/events_routes_controller.dart';
import '../repository/events_routes_repository.dart';
import 'widgets/event_route_card.dart';

class EventsRoutesScreen extends StatelessWidget {
  const EventsRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsRoutesController(EventsRoutesRepositoryImpl()),
      child: const _EventsRoutesView(),
    );
  }
}

class _EventsRoutesView extends StatelessWidget {
  const _EventsRoutesView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EventsRoutesController>();
    final events = controller.state.events;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Events & routes',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                itemCount: events.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventRouteCard(
                    event: event,
                    onTap: () => controller.openEvent(context, event.id),
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
