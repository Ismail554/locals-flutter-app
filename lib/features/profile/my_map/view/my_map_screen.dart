import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:locals/features/map/map/controller/location_service.dart';
import 'package:locals/features/map/map/view/widgets/map_marker_icon_cache.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

import 'package:locals/shared/model/map_pin_info.dart';

import '../controller/my_map_controller.dart';
import '../model/my_map_model.dart';
import '../repository/my_map_repository.dart';

import 'widgets/my_map_legend.dart';

class MyMapScreen extends StatelessWidget {
  const MyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyMapController(
        MyMapRepositoryImpl(),
      ),
      child: const _MyMapView(),
    );
  }
}

class _MyMapView extends StatefulWidget {
  const _MyMapView();

  @override
  State<_MyMapView> createState() => _MyMapViewState();
}

class _MyMapViewState extends State<_MyMapView> {
  GoogleMapController? _mapController;

  Set<Marker> _markers = {};

  LatLng? _currentUserLocation;

  String? _mapStyle;

  /// Prevents old async marker builds from overriding
  /// newer marker builds.
  int _buildToken = 0;

  MyMapController? _myMapController;

  bool _isMapReady = false;

  // ---------------------------------------------------------------------------
  // LIFECYCLE
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    _loadMapStyle();
    _updateCurrentLocation();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _myMapController = context.read<MyMapController>();

      _myMapController!.addListener(_onMapStateChanged);

      // Initial marker build.
      _buildMarkers(_myMapController!.state);
    });
  }

  @override
  void dispose() {
    _myMapController?.removeListener(_onMapStateChanged);

    _mapController?.dispose();

    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // MAP STYLE
  // ---------------------------------------------------------------------------

  Future<void> _loadMapStyle() async {
    try {
      final style = await rootBundle.loadString(
        'assets/map_styles/locals_map_style.json',
      );

      if (!mounted) return;

      setState(() {
        _mapStyle = style;
      });
    } catch (e) {
      debugPrint(
        '[MyMap] Failed to load map style: $e',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // CONTROLLER LISTENER
  // ---------------------------------------------------------------------------

  void _onMapStateChanged() {
    if (!mounted) return;

    final controller = _myMapController;

    if (controller == null) return;

    _buildMarkers(controller.state);
  }

  // ---------------------------------------------------------------------------
  // CURRENT LOCATION
  // ---------------------------------------------------------------------------

  Future<void> _updateCurrentLocation() async {
    try {
      final location = await LocationService.currentLocation();

      if (!mounted) return;

      setState(() {
        _currentUserLocation = location;

        // Merge/refresh the current-location marker straight away without
        // rebuilding place markers, so it appears the moment GPS resolves
        // and the camera is left where it is.
        _markers = {
          ..._markers.where(
            (m) => m.markerId.value != 'current_location',
          ),
          _currentLocationMarker(location),
        };
      });
    } catch (e) {
      debugPrint(
        '[MyMap] Could not get current location: $e',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // CURRENT LOCATION MARKER
  // ---------------------------------------------------------------------------

  /// Blue "You are here" marker anchored at its center (0.5, 0.5) so it sits
  /// exactly on the GPS coordinate, instead of pointing from its bottom tip
  /// (the default anchor) which makes it look offset above the real spot.
  Marker _currentLocationMarker(LatLng location) {
    return Marker(
      markerId: const MarkerId('current_location'),
      position: location,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
      infoWindow: const InfoWindow(title: 'You are here'),
      anchor: const Offset(0.5, 0.5),
    );
  }

  // ---------------------------------------------------------------------------
  // BUILD MARKERS
  // ---------------------------------------------------------------------------

  Future<void> _buildMarkers(
    MyMapModel state,
  ) async {
    final int myToken = ++_buildToken;

    final List<MapPinInfo> pins = state.filteredPins;

    debugPrint(
      '[_buildMarkers] start, '
      'token=$myToken, '
      'filter=${state.selectedFilter.name}, '
      'pins=${pins.length}',
    );

    final iconCache = MapMarkerIconCache.instance;

    final Set<Marker> newMarkers = {};

    for (final pin in pins) {
      // ---------------------------------------------------------------
      // Validate coordinates before creating marker.
      // ---------------------------------------------------------------

      if (!_isValidCoordinate(
        pin.lat,
        pin.lng,
      )) {
        debugPrint(
          '[_buildMarkers] Invalid coordinates '
          'for pin ${pin.id}: '
          '${pin.lat}, ${pin.lng}',
        );

        continue;
      }

      try {
        final BitmapDescriptor icon = await iconCache
            .iconFor(
              tag: pin.tag,
              visited: pin.visited,
            )
            .timeout(
              const Duration(seconds: 5),
              onTimeout: () {
                debugPrint(
                  '[_buildMarkers] Icon timeout '
                  'for pin ${pin.id}',
                );

                return BitmapDescriptor.defaultMarkerWithHue(
                  pin.visited
                      ? BitmapDescriptor.hueGreen
                      : BitmapDescriptor.hueRed,
                );
              },
            );

        newMarkers.add(
          Marker(
            markerId: MarkerId(
              'place_${pin.id}',
            ),
            position: LatLng(
              pin.lat,
              pin.lng,
            ),
            icon: icon,
            infoWindow: InfoWindow(
              title: pin.name,
            ),
            onTap: () {
              if (!mounted) return;

              context
                  .read<MyMapController>()
                  .onPinTap(pin.id);
            },
          ),
        );
      } catch (e) {
        debugPrint(
          '[_buildMarkers] Failed to create '
          'marker for ${pin.id}: $e',
        );

        // -------------------------------------------------------------
        // Safe fallback marker.
        // -------------------------------------------------------------

        newMarkers.add(
          Marker(
            markerId: MarkerId(
              'place_${pin.id}',
            ),
            position: LatLng(
              pin.lat,
              pin.lng,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              pin.visited
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueRed,
            ),
            infoWindow: InfoWindow(
              title: pin.name,
            ),
            onTap: () {
              if (!mounted) return;

              context
                  .read<MyMapController>()
                  .onPinTap(pin.id);
            },
          ),
        );
      }
    }

    // -----------------------------------------------------------------
    // Current-location ("You are here") marker.
    // -----------------------------------------------------------------

    if (_currentUserLocation != null) {
      newMarkers.add(
        _currentLocationMarker(_currentUserLocation!),
      );
    }

    // -----------------------------------------------------------------
    // Ignore old async marker results.
    // -----------------------------------------------------------------

    if (!mounted || myToken != _buildToken) {
      debugPrint(
        '[_buildMarkers] Discarded stale result '
        'token=$myToken '
        '(current=$_buildToken)',
      );

      return;
    }

    debugPrint(
      '[_buildMarkers] done, '
      'token=$myToken, '
      'markers=${newMarkers.length}',
    );

    setState(() {
      _markers = newMarkers;
    });

    // -----------------------------------------------------------------
    // Only center camera when actual place pins exist.
    // -----------------------------------------------------------------

    if (pins.isNotEmpty) {
      await _centerOnPins(pins);
    }
  }

  // ---------------------------------------------------------------------------
  // VALIDATE COORDINATES
  // ---------------------------------------------------------------------------

  bool _isValidCoordinate(
    double latitude,
    double longitude,
  ) {
    if (latitude.isNaN || latitude.isInfinite) {
      return false;
    }

    if (longitude.isNaN || longitude.isInfinite) {
      return false;
    }

    if (latitude < -90 || latitude > 90) {
      return false;
    }

    if (longitude < -180 || longitude > 180) {
      return false;
    }

    if (latitude == 0 && longitude == 0) {
      return false;
    }

    return true;
  }

  // ---------------------------------------------------------------------------
  // CENTER CAMERA ON FILTERED PLACES
  // ---------------------------------------------------------------------------

  Future<void> _centerOnPins(
    List<MapPinInfo> pins,
  ) async {
    final controller = _mapController;

    if (controller == null) {
      return;
    }

    if (!_isMapReady) {
      return;
    }

    if (pins.isEmpty) {
      return;
    }

    // ---------------------------------------------------------------
    // Remove invalid coordinates.
    // ---------------------------------------------------------------

    final validPins = pins.where(
      (pin) => _isValidCoordinate(
        pin.lat,
        pin.lng,
      ),
    ).toList();

    if (validPins.isEmpty) {
      return;
    }

    try {
      // -------------------------------------------------------------
      // ONE PLACE
      // -------------------------------------------------------------

      if (validPins.length == 1) {
        final pin = validPins.first;

        await controller.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(
              pin.lat,
              pin.lng,
            ),
            16.5,
          ),
        );

        return;
      }

      // -------------------------------------------------------------
      // MULTIPLE PLACES
      // -------------------------------------------------------------

      double minLat = 90.0;
      double maxLat = -90.0;

      double minLng = 180.0;
      double maxLng = -180.0;

      for (final pin in validPins) {
        if (pin.lat < minLat) {
          minLat = pin.lat;
        }

        if (pin.lat > maxLat) {
          maxLat = pin.lat;
        }

        if (pin.lng < minLng) {
          minLng = pin.lng;
        }

        if (pin.lng > maxLng) {
          maxLng = pin.lng;
        }
      }

      // -------------------------------------------------------------
      // Prevent zero-size LatLngBounds.
      // Google Maps can throw if SW == NE.
      // -------------------------------------------------------------

      if (minLat == maxLat) {
        minLat -= 0.001;
        maxLat += 0.001;
      }

      if (minLng == maxLng) {
        minLng -= 0.001;
        maxLng += 0.001;
      }

      final bounds = LatLngBounds(
        southwest: LatLng(
          minLat,
          minLng,
        ),
        northeast: LatLng(
          maxLat,
          maxLng,
        ),
      );

      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
          70,
        ),
      );
    } catch (e) {
      debugPrint(
        '[_centerOnPins] Camera error: $e',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // RETRY
  // ---------------------------------------------------------------------------

  Future<void> _retry() async {
    final controller = _myMapController;

    if (controller == null) {
      return;
    }

    await controller.loadPersonalMap();
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(
    BuildContext context,
  ) {
    final controller = context.watch<MyMapController>();

    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------------------------------------------------
            // HEADER
            // ---------------------------------------------------------

            Padding(
              padding: EdgeInsets.fromLTRB(
                20.w,
                8.h,
                20.w,
                0,
              ),
              child: ProfileScreenHeader(
                title: context.l10n.myMapTitle,
                onBack: () => context.pop(),
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            // ---------------------------------------------------------
            // FILTER
            // ---------------------------------------------------------

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: ProfileSegmentedControl(
                options: [
                  ProfileSegmentOption(
                    label: context.l10n.myMapFilterAll,
                    value: MyMapFilter.all.name,
                  ),
                  ProfileSegmentOption(
                    label: context.l10n.myMapFilterVisited(
                      state.visitedCount,
                    ),
                    value: MyMapFilter.visited.name,
                  ),
                  ProfileSegmentOption(
                    label: context.l10n.myMapFilterUnvisited(
                      state.unvisitedCount,
                    ),
                    value: MyMapFilter.unvisited.name,
                  ),
                ],
                selectedValue: state.selectedFilter.name,
                onChanged: (value) {
                  try {
                    final filter =
                        MyMapFilter.values.byName(value);

                    controller.selectFilter(filter);
                  } catch (e) {
                    debugPrint(
                      '[MyMap] Invalid filter value: $value',
                    );
                  }
                },
              ),
            ),

            SizedBox(
              height: 12.h,
            ),

            // ---------------------------------------------------------
            // MAP
            // ---------------------------------------------------------

            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  0,
                  20.w,
                  20.h,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ),
                  child: Stack(
                    children: [
                      // -------------------------------------------------
                      // GOOGLE MAP
                      // -------------------------------------------------

                      GoogleMap(
                        mapType: MapType.normal,

                        style: _mapStyle,

                        initialCameraPosition:
                            const CameraPosition(
                          target: LatLng(
                            23.7809,
                            90.407992,
                          ),
                          zoom: 12,
                        ),

                        markers: _markers,

                        // Let Google Maps handle the
                        // user's location.
                        myLocationEnabled: true,

                        myLocationButtonEnabled: true,

                        zoomControlsEnabled: false,

                        compassEnabled: true,

                        mapToolbarEnabled: false,

                        onMapCreated:
                            (GoogleMapController controller) {
                          _mapController = controller;

                          _isMapReady = true;

                          final currentState =
                              context
                                  .read<MyMapController>()
                                  .state;

                          if (currentState
                              .filteredPins
                              .isNotEmpty) {
                            _centerOnPins(
                              currentState.filteredPins,
                            );
                          }
                        },
                      ),

                      // -------------------------------------------------
                      // LEGEND
                      // -------------------------------------------------

                      if (state.filteredPins.isNotEmpty &&
                          controller.status ==
                              MyMapStatus.success)
                        Positioned(
                          left: 12.w,
                          right: 12.w,
                          bottom: 12.h,
                          child: _MapLegendContainer(
                            child: const MyMapLegend(),
                          ),
                        ),

                      // -------------------------------------------------
                      // LOADING
                      // -------------------------------------------------

                      if (controller.status ==
                          MyMapStatus.loading)
                        const _MapLoadingOverlay(),

                      // -------------------------------------------------
                      // EMPTY STATE
                      // -------------------------------------------------

                      if (controller.status ==
                              MyMapStatus.success &&
                          state.filteredPins.isEmpty)
                        _MapEmptyState(
                          filter: state.selectedFilter,
                        ),

                      // -------------------------------------------------
                      // ERROR STATE
                      // -------------------------------------------------

                      if (controller.status ==
                          MyMapStatus.error)
                        _MapErrorState(
                          onRetry: _retry,
                        ),
                    ],
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

// =============================================================================
// MAP LOADING OVERLAY
// =============================================================================

class _MapLoadingOverlay extends StatelessWidget {
  const _MapLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.75),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 18.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              16.r,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                'Loading your map...',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.levelGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// EMPTY STATE
// =============================================================================

class _MapEmptyState extends StatelessWidget {
  final MyMapFilter filter;

  const _MapEmptyState({
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final String title;
    late final String subtitle;

    switch (filter) {
      case MyMapFilter.all:
        icon = Icons.map_outlined;

        title = 'No places yet';

        subtitle =
            'Your personal map is empty. '
            'Start exploring places to build your map.';

        break;

      case MyMapFilter.visited:
        icon = Icons.check_circle_outline;

        title = 'No visited places yet';

        subtitle =
            'Start exploring and mark places as visited '
            'to see them here.';

        break;

      case MyMapFilter.unvisited:
        icon = Icons.celebration_outlined;

        title = 'You\'ve visited everywhere!';

        subtitle =
            'Amazing! There are no unvisited places '
            'remaining on your map.';

        break;
    }

    return Container(
      color: Colors.white.withOpacity(0.88),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: AppColors.levelGrey.withOpacity(
                    0.10,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 34.sp,
                  color: AppColors.levelGrey,
                ),
              ),

              SizedBox(
                height: 16.h,
              ),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              SizedBox(
                height: 8.h,
              ),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                  color: AppColors.levelGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// ERROR STATE
// =============================================================================

class _MapErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _MapErrorState({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.94),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: AppColors.levelGrey.withOpacity(
                    0.10,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cloud_off_outlined,
                  size: 34.sp,
                  color: AppColors.levelGrey,
                ),
              ),

              SizedBox(
                height: 16.h,
              ),

              Text(
                'Couldn\'t load your map',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              SizedBox(
                height: 8.h,
              ),

              Text(
                'Please check your internet connection '
                'and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                  color: AppColors.levelGrey,
                ),
              ),

              SizedBox(
                height: 18.h,
              ),

              ElevatedButton(
                onPressed: onRetry,
                child: const Text(
                  'Try Again',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// MAP LEGEND CONTAINER
// =============================================================================

class _MapLegendContainer extends StatelessWidget {
  final Widget child;

  const _MapLegendContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(
          14.r,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: child,
    );
  }
}