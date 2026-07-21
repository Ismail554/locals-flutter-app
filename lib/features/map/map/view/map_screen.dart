import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/features/map/map/controller/location_service.dart';
import 'package:locals/features/map/map/view/widgets/business_banner.dart';
import 'package:locals/features/map/map/view/widgets/map_marker_icon_cache.dart';
import 'package:locals/shared/theme/app_colors.dart';
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
    final resolvedArgs =
        screenArgs ?? MapScreenArgs.fromExtra(GoRouterState.of(context).extra);
    return ChangeNotifierProvider(
      create: (_) =>
          MapController(MapRepositoryImpl(), screenArgs: resolvedArgs),
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
  String? _lastMarkersKey;

  String? _lastRouteLocationKey;
  LatLng? _currentUserLocation;

  bool _isBuildingMarkers = false;

  // ─── Current Location ─────────────────────────────────────────────────────

  Future<void> _updateCurrentLocation() async {
    try {
      final loc = await LocationService.currentLocation();
      if (!mounted) return;

      setState(() => _currentUserLocation = loc);
      _rebuildMarkers(); // Only rebuild once location is ready
    } catch (e) {
      debugPrint("Could not get current location: $e");
    }
  }

  Future<void> _rebuildMarkers() async {
    if (_isBuildingMarkers) return;
    _isBuildingMarkers = true;

    final controller = context.read<MapController>();
    final pins = controller.state.pins;

    final currentKey = pins.map((p) => '${p.id}_${p.visited}').join(',') +
        (_currentUserLocation?.toString() ?? '');

    if (currentKey == _lastMarkersKey) {
      _isBuildingMarkers = false;
      return;
    }

    _lastMarkersKey = currentKey;

    final iconCache = MapMarkerIconCache.instance;
    final markers = <Marker>{};

    // Add place pins
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

    // Add Current Location Pin
    if (_currentUserLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentUserLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: "You are here"),
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }

    if (mounted) {
      setState(() => _markers = markers);
    }

    _isBuildingMarkers = false;
  }

  // ─── Helper Methods ───────────────────────────────────────────────────────

  LatLngBounds _boundsFromLatLngList(List<LatLng> points) {
    if (points.isEmpty) {
      return LatLngBounds(
        southwest: const LatLng(23.7809, 90.407992),
        northeast: const LatLng(23.7809, 90.407992),
      );
    }

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  Future<void> _fitRouteToBounds(MapController controller) async {
    if (mapController == null) return;

    final polylines = controller.state.polylines;
    if (polylines.isEmpty) return;

    final routePolyline = polylines.firstWhere(
      (p) => p.polylineId.value == 'route',
      orElse: () => polylines.first,
    );

    if (routePolyline.points.isEmpty) return;

    final bounds = _boundsFromLatLngList(routePolyline.points);

    await mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }

  Future<void> _centerOnHighlighted(MapController controller) async {
    if (mapController == null) return;
    final highlighted = controller.state.highlightedLocation;
    if (highlighted == null) return;

    await mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(highlighted.latitude, highlighted.longitude),
        16.0,
      ),
    );
  }

  // ─── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _updateCurrentLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rebuildMarkers();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MapController>();
    final state = controller.state;

    final mission = state.activeMission;
    final highlightedLocation = state.highlightedLocation;
    final bottomLocation = mission?.activeLocation ?? highlightedLocation;

    // Route camera fitting
    if (state.polylines.isNotEmpty && highlightedLocation != null) {
      final locationKey =
          '${highlightedLocation.latitude},${highlightedLocation.longitude}';

      if (_lastRouteLocationKey != locationKey) {
        _lastRouteLocationKey = locationKey;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _fitRouteToBounds(controller);
        });
      }
    }

    // Initial centering for highlighted location
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && state.highlightedLocation != null) {
        _centerOnHighlighted(controller);
      }
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(23.7809, 90.407992),
            zoom: 13,
          ),
          markers: _markers,
          polylines: state.polylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          compassEnabled: true,

          onMapCreated: (GoogleMapController ctrl) {
            mapController = ctrl;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateCurrentLocation();
            });
          },
        ),
        Positioned(
          right: 16.w,
          bottom: 180.h,
          child: FloatingActionButton.small(
            backgroundColor: controller.isTrackingLive
                ? AppColors.actionPink
                : Colors.white,
            onPressed: () {
              if (controller.isTrackingLive) {
                controller.stopLiveTracking();
              } else {
                controller.startLiveTracking();
              }
            },
            child: Icon(
              controller.isTrackingLive
                  ? Icons.location_off
                  : Icons.my_location,
              color: controller.isTrackingLive
                  ? Colors.white
                  : AppColors.actionPink,
            ),
          ),
        ),

        if (state.isLoadingPins)
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator()),
          ),

        // Top UI (Search, Filters, Notifications)
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

        // Business Banner
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

        // Bottom UI
        if (bottomLocation != null) ...[
          Positioned(
            right: 16.w,
            bottom: 108.h,
            child: SafeArea(
              top: false,
              child: _CheckInFab(
                onTap: () => controller.checkIn(context),
                enabled: controller.isNearDestination,
              ),
            ),
          ),
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
      ],
    );
  }
}

class _CheckInFab extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;

  const _CheckInFab({super.key, required this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? AppColors.actionPink : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(24.r),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                context.l10n.checkInButtonLabel,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
