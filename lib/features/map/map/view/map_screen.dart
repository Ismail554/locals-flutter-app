import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/map_controller.dart';
import '../model/map_mission_args.dart';
import '../repository/map_repository.dart';
import 'widgets/map_background.dart';
import 'widgets/map_circle_action_button.dart';
import 'widgets/map_location_detail_card.dart';
import 'widgets/map_mission_progress_card.dart';
import 'widgets/map_pin_marker.dart';
import 'widgets/map_search_bar.dart';

class MapScreen extends StatelessWidget {
  final MapMissionArgs? missionArgs;

  const MapScreen({super.key, this.missionArgs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapController(
        MapRepositoryImpl(),
        missionArgs: missionArgs,
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
    final mission = controller.state.activeMission;

    return LayoutBuilder(
      builder: (context, constraints) {
        final mapWidth = constraints.maxWidth;
        final mapHeight = constraints.maxHeight;

        return Stack(
          fit: StackFit.expand,
          children: [
            const MapBackground(),
            ...controller.state.pins.map((pin) {
              return Positioned(
                left: pin.x * mapWidth - 18.w,
                top: pin.y * mapHeight - 24.h,
                child: MapPinMarker(type: pin.type),
              );
            }),
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
                              query: controller.state.searchQuery,
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
                            showBadge: controller.state.hasUnreadNotifications,
                            onPressed: () =>
                                controller.openNotifications(context),
                          ),
                        ],
                      ),
                      if (mission != null) ...[
                        SizedBox(height: 12.h),
                        MapMissionProgressCard(
                          mission: mission,
                          onTap: () =>
                              controller.openEventsProgressMap(context),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (mission != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    child: MapLocationDetailCard(
                      location: mission.activeLocation,
                      onTap: () =>
                          controller.openActiveLocationDetails(context),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
