import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/features/map/map/view/widgets/business_banner.dart';
import 'package:locals/features/map/map/view/widgets/map_marker_icon_cache.dart';
import 'package:provider/provider.dart';

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
      create: (_) => MapController(MapRepositoryImpl(), screenArgs: screenArgs),
      child: const _MapView(),
    );
  }
}

class _MapView extends StatefulWidget {
  const _MapView();

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  String? _markersBuiltForPinIds;

  Future<void> _buildMarkers(MapController controller) async {
    final pins = controller.state.pins;

    // Skip rebuild if the same pin set was already turned into markers
    final pinIdsKey = pins.map((p) => '${p.id}_${p.visited}').join(',');
    if (pinIdsKey == _markersBuiltForPinIds) return;
    _markersBuiltForPinIds = pinIdsKey;

    final iconCache = MapMarkerIconCache.instance;
    final markers = <Marker>{};

    for (final pin in pins) {
      final icon = await iconCache.iconFor(tag: pin.tag, visited: pin.visited);
      markers.add(
        Marker(
          markerId: MarkerId(pin.id),
          position: LatLng(pin.lat, pin.lng),
          icon: icon,
          infoWindow: InfoWindow(title: pin.name),
          onTap: () => controller.onPinTap(context, pin.id),
        ),
      );
    }

    if (mounted) {
      setState(() => _markers = markers);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MapController>();
    final state = controller.state;

    final mission = state.activeMission;
    final highlightedLocation = state.highlightedLocation;
    final bottomLocation = mission?.activeLocation ?? highlightedLocation;

    // Rebuild custom markers whenever the pin list changes
    _buildMarkers(controller);

    return Stack(
      fit: StackFit.expand,
      children: [
        /// 🌍 REAL GOOGLE MAP
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.3851, 2.1734), // Barcelona, matches place data
            zoom: 13,
          ),
          markers: _markers,
          onMapCreated: (c) => mapController = c,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
        ),

        if (state.isLoadingPins)
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator()),
          ),

        /// TOP UI
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
                        onPressed: () => controller.openNotifications(context),
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

        Positioned(
          top: 140.h,
          left: 16.w,
          right: 16.w,
          child: BusinessBanner(
            title: "Café del Born",
            subtitle: null,
            type: BannerType.businessOfTheMonth,
            onTap: () =>
                controller.openRestaurantDetails(context, 'cafe_del_born'),
            onClose: () {},
          ),
        ),

        /// BOTTOM CARD
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
