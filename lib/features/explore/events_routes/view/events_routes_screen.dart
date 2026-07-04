import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/events_routes_controller.dart';
import '../repository/events_routes_repository.dart';
import 'widgets/event_route_card.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

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
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.eventsRoutesTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.errorMessage != null && state.events.isEmpty
                      ? Center(
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color: AppColors.levelGrey,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: controller.refresh,
                          child: ListView.separated(
                            padding:
                                EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                            itemCount: state.events.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final event = state.events[index];
                              return EventRouteCard(
                                event: event,
                                onTap: () => controller.openEvent(
                                    context, event.id),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}