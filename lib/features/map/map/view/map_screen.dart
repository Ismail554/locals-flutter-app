import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/map/scrollable_map_canvas.dart';
import '../controller/map_controller.dart';
import '../model/map_screen_args.dart';
import '../repository/map_repository.dart';
import 'widgets/map_circle_action_button.dart';
import 'widgets/map_location_detail_card.dart';
import 'widgets/map_mission_progress_card.dart';
import 'widgets/map_search_bar.dart';

class MapScreen extends StatelessWidget {
  final MapScreenArgs? screenArgs;

  const MapScreen({super.key, this.screenArgs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapController(
        MapRepositoryImpl(),
        screenArgs: screenArgs,
      ),
      child: const _MapView(),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MapController>();
    final state = controller.state;
    final mission = state.activeMission;
    final highlightedLocation = state.highlightedLocation;
    final bottomLocation = mission?.activeLocation ?? highlightedLocation;

    return Stack(
      fit: StackFit.expand,
      children: [
        ScrollableMapCanvas(
          pins: state.pins,
          selectedPinId: state.selectedPinId,
          focusPinId: state.selectedPinId,
          onPinTap: controller.onPinTap,
          onBackgroundTap: controller.clearSelectedPin,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: MapSearchBar(
                          query: state.searchQuery,
                          onTap: () => controller.openSearch(context),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      MapCircleActionButton(
                        icon: Icons.tune,
                        onPressed: () => controller.openFilters(context),
                      ),
                      SizedBox(width: 10.w),
                      MapCircleActionButton(
                        icon: Icons.notifications_none,
                        showBadge: state.hasUnreadNotifications,
                        onPressed: () =>
                            controller.openNotifications(context),
                      ),
                    ],
                  ),
                  if (mission != null) ...[
                    SizedBox(height: 12.h),
                    MapMissionProgressCard(
                      mission: mission,
                      onTap: () => controller.openEventsProgressMap(context),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (bottomLocation != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: MapLocationDetailCard(
                  location: bottomLocation,
                  onTap: () => controller.openActiveLocationDetails(context),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
