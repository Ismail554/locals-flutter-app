import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/features/map/map/controller/location_service.dart';
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

  const MapScreen({
    super.key,
    this.screenArgs,
  });

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

class _MapView extends StatefulWidget {
  const _MapView();

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  GoogleMapController? mapController;

  Set<Marker> _markers = {};

  String? _markersBuiltForPinIds;

  bool _cameraMoved = false;

  Future<void> _buildMarkers(MapController controller) async {
    final pins = controller.state.pins;

    final pinIdsKey = pins.map((p) => '${p.id}_${p.visited}').join(',');

    if (pinIdsKey == _markersBuiltForPinIds) return;

    _markersBuiltForPinIds = pinIdsKey;

    final iconCache = MapMarkerIconCache.instance;

    final markers = <Marker>{};

    for (final pin in pins) {
      final icon = await iconCache.iconFor(
        tag: pin.tag,
        visited: pin.visited,
      );

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

    if (!mounted) return;

    setState(() {
      _markers = markers;
    });
  }

  Future<void> _moveCameraToRoute(MapController controller) async {
    if (_cameraMoved) return;

    if (mapController == null) return;

    final location = controller.state.highlightedLocation;

    if (location == null) return;

    try {
      final current = await LocationService.currentLocation();

      final destination = LatLng(
        location.latitude,
        location.longitude,
      );

      final southwest = LatLng(
        min(current.latitude, destination.latitude),
        min(current.longitude, destination.longitude),
      );

      final northeast = LatLng(
        max(current.latitude, destination.latitude),
        max(current.longitude, destination.longitude),
      );

      await mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: southwest,
            northeast: northeast,
          ),
          80,
        ),
      );

      _cameraMoved = true;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MapController>();

    final state = controller.state;

    final mission = state.activeMission;

    final highlightedLocation = state.highlightedLocation;

    final bottomLocation =
        mission?.activeLocation ?? highlightedLocation;

    _buildMarkers(controller);

    if (state.polylines.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _moveCameraToRoute(controller);
      });
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.3851, 2.1734),
            zoom: 13,
          ),

          markers: _markers,

          /// THIS IS WHAT WAS MISSING
          polylines: state.polylines,

          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,

          onMapCreated: (controller) {
            mapController = controller;
          },
        ),

        if (state.isLoadingPins)
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                12.h,
                16.w,
                0,
              ),
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
                        onPressed: () =>
                            controller.openFilters(context),
                      ),
                      SizedBox(width: 10.w),
                      MapCircleActionButton(
                        icon: Icons.notifications_none,
                        showBadge:
                            state.hasUnreadNotifications,
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

        Positioned(
          top: 140.h,
          left: 16.w,
          right: 16.w,
          child: BusinessBanner(
            title: "Café del Born",
            subtitle: null,
            type: BannerType.businessOfTheMonth,
            onTap: () => controller.openRestaurantDetails(
              context,
              'cafe_del_born',
            ),
            onClose: () {},
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
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  0,
                  16.w,
                  16.h,
                ),
                child: MapLocationDetailCard(
                  location: bottomLocation,
                  onTap: () =>
                      controller.openActiveLocationDetails(context),
                ),
              ),
            ),
          ),
      ],
    );
  }
}