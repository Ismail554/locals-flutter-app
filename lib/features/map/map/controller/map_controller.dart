import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/features/explore/events_progress_map/model/events_progress_map_args.dart';
import 'package:locals/features/explore/restaurant_view_details/model/restaurant_view_details_args.dart';
import 'package:locals/features/map/map/controller/location_service.dart';
import 'package:locals/features/map/map/controller/route_service.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';
import 'package:locals/features/missions/check_in/view/checkin_bottom_sheet.dart';
import 'package:locals/shared/components/pin_details_sheet.dart';
import 'package:locals/shared/model/map_pin_details.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../filters/model/filters_model.dart';
import '../../search/repository/map_search_repository.dart';
import '../model/map_screen_args.dart';
import '../model/map_model.dart';
import '../repository/map_repository.dart';

class MapController extends ChangeNotifier {
  final MapRepository repo;
  MapModel state;

  Timer? _searchDebounce;
  StreamSubscription<LatLng>? _locationSubscription;
  bool isNearDestination = false;
  bool isTrackingLive = false;
  bool get isFocusedMode => _isFocusedMode;

  bool get _isFocusedMode =>
      state.showRoute && state.highlightedLocation != null;

  MapController(this.repo, {MapScreenArgs? screenArgs})
    : state = MapModel(
        activeMission: screenArgs?.mission?.toActiveMission(),
        selectedPinId: screenArgs?.focusedPinId,
        highlightedLocation: screenArgs?.highlightedLocation,
        showRoute: screenArgs?.showRoute ?? false,
        initialCenter: screenArgs?.initialCenter,
        initialZoom: screenArgs?.initialZoom,
      ) {
    _initContext();
  }

  Future<void> _initContext() async {
    await _loadPlaces();

    if (_isFocusedMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      await loadRoute();
    }
  }

void startLiveTracking() {
    if (isTrackingLive) return;
    isTrackingLive = true;

    _locationSubscription?.cancel();
    _locationSubscription = LocationService.locationStream().listen((currentLoc) {
      final destination = state.highlightedLocation;
      if (destination == null) return;

      final destLatLng = LatLng(destination.latitude, destination.longitude);
      final distance = Geolocator.distanceBetween(
        currentLoc.latitude,
        currentLoc.longitude,
        destLatLng.latitude,
        destLatLng.longitude,
      );

      final nearNow = distance < 50;

      if (nearNow != isNearDestination) {
        isNearDestination = nearNow;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void stopLiveTracking() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    isTrackingLive = false;
    isNearDestination = false;
    notifyListeners();
  }

  // ─── Places Loading ─────────────────────────────────────────────────────────

  Future<void> loadRoute() async {
    debugPrint("=== LOAD ROUTE ===");
    if (!state.showRoute || state.highlightedLocation == null) return;

    final location = state.highlightedLocation!;

    try {
      final current = await LocationService.currentLocation();
      final destination = LatLng(location.latitude, location.longitude);

      debugPrint("Current: ${current.latitude}, ${current.longitude}");
      debugPrint(
        "Destination: ${destination.latitude}, ${destination.longitude}",
      );

      final points = await RouteService.instance.getRoute(
        origin: current,
        destination: destination,
      );

      if (points.isNotEmpty) {
        state = state.copyWith(
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: points,
              width: 8,
              color: AppColors.actionPink,
              geodesic: true,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
            ),
          },
        );
        debugPrint("✅ Real curved route drawn with ${points.length} points");
      } else {
        // Fallback straight line
        state = state.copyWith(
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: [current, destination],
              width: 6,
              color: Colors.orange,
            ),
          },
        );
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Route Error: $e");
    }
  }

  Future<void> _loadPlaces() async {
    state = state.copyWith(isLoadingPins: true);
    notifyListeners();

    try {
      List<MapPinInfo> pins = await repo.fetchPlaces(
        search: state.searchQuery,
        categorySlug: _resolveCategorySlug(),
        placeType: _resolvePlaceType(),
        visitStatus: _resolveVisitStatus(),
      );

      // === Focused Mode (Mission, Featured Route, Single Place) ===
      if (_isFocusedMode && state.highlightedLocation != null) {
        final targetId = state.highlightedLocation!.resolvedLocationId;

        pins = pins.where((pin) => pin.id == targetId).toList();

        // Fallback: Create pin from highlighted location if not returned by API
        if (pins.isEmpty) {
          final loc = state.highlightedLocation!;
          pins = [
            MapPinInfo(
              id: loc.resolvedLocationId,
              name: loc.name,
              level: 1, // required field
              lat: loc.latitude,
              lng: loc.longitude,
              tag: _getPinTag(loc.category),
              visited: false,
              category: loc.category,
              address: loc.address,
              points: loc.points,
              accentColor: loc.imageColor,
            ),
          ];
        }
      }

      state = state.copyWith(pins: pins, isLoadingPins: false);
      notifyListeners();

      if (_isFocusedMode) {
        await Future.delayed(const Duration(milliseconds: 800));
        await loadRoute();
      }
    } catch (e) {
      debugPrint('Places fetch error: $e');
      state = state.copyWith(isLoadingPins: false);
      notifyListeners();
    }
  }

void showRouteToPin(String pinId) {
  final pin = state.getPinById(pinId);
  if (pin == null) {
    debugPrint("❌ Pin not found: $pinId");
    return;
  }

  debugPrint("📍 Showing route to pin: ${pin.name}");

  state = state.copyWith(
    highlightedLocation: MapActiveLocation(
      locationId: pin.id,
      category: pin.category ?? 'PLACE',
      seal: 'Local spot',
      name: pin.name,
      address: pin.address ?? '',
      points: pin.points ?? 30,
      imageColor: pin.accentColor ?? const Color(0xFFD4C4B0),
      latitude: pin.lat,
      longitude: pin.lng,
    ),
    showRoute: true,
    selectedPinId: null,
  );

  notifyListeners();

  // Load the actual polyline route
  loadRoute();
}

  /// Call this from Pin Details Sheet when user taps "Directions"
void openDirectionsFromPin(String pinId) {
  final pin = state.getPinById(pinId);
  if (pin == null) return;

  // Set focused mode
  state = state.copyWith(
    highlightedLocation: MapActiveLocation(
      locationId: pin.id,
      category: pin.category ?? 'PLACE',
      seal: 'Local spot',
      name: pin.name,
      address: pin.address ?? '',
      points: pin.points ?? 30,
      imageColor: pin.accentColor ?? const Color(0xFFD4C4B0),
      latitude: pin.lat,
      longitude: pin.lng,
    ),
    showRoute: true,
    selectedPinId: null, // optional: clear selection
  );

  notifyListeners();

  // Load the route
  loadRoute();
}

  MapPinTag _getPinTag(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('cafe') || cat.contains('coffee'))
      return MapPinTag.business;
    if (cat.contains('bar')) return MapPinTag.business;
    if (cat.contains('restaurant') || cat.contains('food'))
      return MapPinTag.business;
    if (cat.contains('event')) return MapPinTag.sponsoredOrEvent;
    return MapPinTag.pointOfInterest;
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  String? _resolveCategorySlug() {
    final selected = state.filters.selectedCategoryIds;
    if (selected.isEmpty) return null;
    return selected.first;
  }

  String? _resolvePlaceType() {
    switch (state.filters.placeType) {
      case PlaceTypeFilter.businesses:
        return 'BUSINESS';
      case PlaceTypeFilter.event:
        return 'POI';
      case PlaceTypeFilter.poi:
        return null;
    }
  }

  String? _resolveVisitStatus() {
    switch (state.filters.visitStatus) {
      case VisitStatusFilter.visited:
        return 'VISITED';
      case VisitStatusFilter.unvisited:
        return 'UNVISITED';
      case VisitStatusFilter.both:
        return null;
    }
  }

  // ─── Pin Interaction ────────────────────────────────────────────────────────

  void onPinTap(BuildContext context, String pinId) {
    final pin = state.getPinById(pinId);
    if (pin == null) return;

    state = state.copyWith(
      selectedPinId: state.selectedPinId == pinId ? null : pinId,
    );
    notifyListeners();

    _showPinDetailsBottomSheet(context, pin);
  }

  void _showPinDetailsBottomSheet(BuildContext context, MapPinInfo pin) {
    final details = MapPinDetails(
      id: pin.id,
      category: pin.category ?? 'PLACE',
      name: pin.name,
      address: pin.address ?? 'Unknown Address',
      points: pin.points ?? 30,
      accentColor: pin.accentColor ?? const Color(0xFFD4C4B0),
      imageUrl: pin.imageUrl,
      latitude: pin.lat,
      longitude: pin.lng,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PinDetailsSheet(pin: pin, controller: this),
    );
  }

  void clearSelectedPin() {
    if (state.selectedPinId == null) return;
    state = state.copyWith(clearSelectedPin: true);
    notifyListeners();
  }

  // ─── Check-In ───────────────────────────────────────────────────────────────

  Future<void> checkIn(BuildContext context) async {
    final location =
        state.highlightedLocation ?? state.activeMission?.activeLocation;
    if (location == null) return;

    final result = await showCheckInSheet(
      context,
      placeId: location.resolvedLocationId,
      placeName: location.name,
    );

    if (result == null || !context.mounted) return;

    await _loadPlaces();

    if (result.missionCompleted && context.mounted) {
      context.pop();
    }
  }

  // ─── Navigation ─────────────────────────────────────────────────────────────

  Future<void> openSearch(BuildContext context) async {
    final result = await context.push<String>(
      '/map_search',
      extra: state.searchQuery,
    );
    if (result != null && result.trim().isNotEmpty) {
      MapSearchRepositoryImpl().addRecentSearch(result.trim());
      setSearchQuery(result.trim());
    }
  }

  Future<void> openFilters(BuildContext context) async {
    await context.push<MapFiltersState>(
      '/filters',
      extra: FiltersArgs(initial: state.filters, onApply: applyFilters),
    );
  }

  Future<void> openNotifications(BuildContext context) async {
    await context.push('/notification');
    state = state.copyWith(hasUnreadNotifications: false);
    notifyListeners();
  }

  void openActiveLocationDetails(BuildContext context) {
    final location =
        state.highlightedLocation ?? state.activeMission?.activeLocation;
    if (location == null) return;

    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: location.resolvedLocationId),
    );
  }

  void openEventsProgressMap(BuildContext context) {
    final mission = state.activeMission;
    if (mission == null) return;

    context.push(
      '/events_progress_map',
      extra: EventsProgressMapArgs(
        eventId: mission.eventId ?? 'modernist_weekend',
        completedStops: mission.completedCount,
      ),
    );
  }

  void openRestaurantDetails(BuildContext context, String locationId) {
    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: locationId),
    );
  }

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value);
    notifyListeners();

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      _loadPlaces();
    });
  }

  void applyFilters(MapFiltersState filters) {
    state = state.copyWith(filters: filters);
    notifyListeners();
    _loadPlaces();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
