import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:locals/shared/model/map_pin_info.dart';
import '../model/map_mission_args.dart';
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
  String? _markerSignature;

  String? _lastRouteLocationKey;
  LatLng? _currentUserLocation;

  bool _isBuildingMarkers = false;
  String? _mapStyle;
  String? _locationError;

  // ─── Current Location ─────────────────────────────────────────────────────

  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString(
      'assets/map_styles/locals_map_style.json',
    );
    if (mounted) {
      setState(() => _mapStyle = style);
    }
  }

  Future<void> _updateCurrentLocation() async {
    try {
      final loc = await LocationService.currentLocation();
      if (!mounted) return;

      if (_currentUserLocation != loc) {
        setState(() {
          _currentUserLocation = loc;
          _locationError = null;
        });
      }
      _rebuildMarkers(); // Only rebuild once location is ready
    } catch (e) {
      debugPrint("Could not get current location: $e");
      if (mounted && _locationError != e.toString()) {
        setState(() => _locationError = e.toString());
      }
    }
  }

  Future<void> _rebuildMarkers() async {
    if (_isBuildingMarkers) return;
    _isBuildingMarkers = true;

    final controller = context.read<MapController>();
    final pins = controller.state.pins;

    final currentKey =
        pins.map((p) => '${p.id}_${p.visited}').join(',') +
        (_currentUserLocation?.toString() ?? '');

    if (currentKey == _lastMarkersKey) {
      _isBuildingMarkers = false;
      return;
    }

    _lastMarkersKey = currentKey;

    if (pins.length > 200) {
      final clusteredMarkers = await _buildClusteredMarkers(pins, controller);
      _updateMarkersIfChanged(clusteredMarkers);
      _isBuildingMarkers = false;
      return;
    }

    final iconCache = MapMarkerIconCache.instance;
    final markers = <Marker>{};

    // Add place pins
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

    // Add Current Location Pin
    if (_currentUserLocation != null) {
      markers.add(_currentLocationMarker(_currentUserLocation!));
    }
    final destination = controller.state.highlightedLocation;
    if (destination != null) markers.add(_destinationMarker(destination));

    _updateMarkersIfChanged(markers);

    _isBuildingMarkers = false;
  }

  void _updateMarkersIfChanged(Set<Marker> markers) {
    final signature =
        markers
            .map(
              (marker) =>
                  '${marker.markerId.value}:${marker.position.latitude},${marker.position.longitude}',
            )
            .toList()
          ..sort();
    final nextSignature = signature.join('|');
    if (!mounted || nextSignature == _markerSignature) return;
    _markerSignature = nextSignature;
    setState(() => _markers = markers);
  }

  Future<Set<Marker>> _buildClusteredMarkers(
    List<MapPinInfo> pins,
    MapController controller,
  ) async {
    const cellSize = 0.002;
    final groups = <String, List<MapPinInfo>>{};

    for (final pin in pins) {
      final latCell = (pin.lat / cellSize).floor();
      final lngCell = (pin.lng / cellSize).floor();
      groups.putIfAbsent('$latCell:$lngCell', () => []).add(pin);
    }

    final markers = <Marker>{};
    for (final group in groups.values) {
      if (group.length == 1) {
        final pin = group.first;
        final icon = await MapMarkerIconCache.instance.iconFor(
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
        continue;
      }

      final center = LatLng(
        group.map((pin) => pin.lat).reduce((a, b) => a + b) / group.length,
        group.map((pin) => pin.lng).reduce((a, b) => a + b) / group.length,
      );
      markers.add(
        Marker(
          markerId: MarkerId('cluster_${group.first.id}'),
          position: center,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          infoWindow: InfoWindow(title: '${group.length} places'),
          onTap: () => mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(center, 16),
          ),
        ),
      );
    }

    if (_currentUserLocation != null) {
      markers.add(_currentLocationMarker(_currentUserLocation!));
    }
    final destination = controller.state.highlightedLocation;
    if (destination != null) markers.add(_destinationMarker(destination));
    return markers;
  }

  Marker _currentLocationMarker(LatLng location) => Marker(
    markerId: const MarkerId('current_location'),
    position: location,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    infoWindow: const InfoWindow(title: 'You are here'),
    anchor: const Offset(0.5, 0.5),
  );

  Marker _destinationMarker(MapActiveLocation location) => Marker(
    markerId: const MarkerId('route_destination'),
    position: LatLng(location.latitude, location.longitude),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    infoWindow: InfoWindow(title: location.name),
  );

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
    _loadMapStyle();
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
          style: _mapStyle,
          initialCameraPosition: CameraPosition(
            target: state.initialCenter ?? const LatLng(23.7809, 90.407992),
            zoom: state.initialZoom ?? 13,
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
          onCameraIdle: () async {
            if (mapController == null || !mounted) return;
            final controller = context.read<MapController>();
            final bounds = await mapController!.getVisibleRegion();
            if (mounted) {
              controller.loadVisibleRegion(bounds);
            }
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

        if (state.errorMessage != null)
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: bottomLocation == null ? 24.h : 150.h,
            child: _MapErrorBanner(
              message: state.errorMessage!,
              onRetry: controller.retry,
            ),
          ),

        if (_locationError != null)
          Positioned(
            left: 16.w,
            right: 16.w,
            top: 100.h,
            child: _MapErrorBanner(
              message: _locationError!,
              onRetry: _updateCurrentLocation,
            ),
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
            type: BannerType.businessOfTheMonth,
            onTap: (placeId) =>
                controller.openRestaurantDetails(context, placeId),
            onClose: () {},
          ),
        ),

        // Bottom UI
        if (bottomLocation != null) ...[
          // Positioned(
          //   right: 16.w,
          //   bottom: 108.h,
          //   child: SafeArea(
          //     top: false,
          //     child: _CheckInFab(
          //       onTap: () => controller.checkIn(context),
          //       enabled: controller.isNearDestination,
          //     ),
          //   ),
          // ),
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

class _MapErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _MapErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 10.h, 8.w, 10.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.black, fontSize: 13.sp),
              ),
            ),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
