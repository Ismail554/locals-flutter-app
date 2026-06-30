import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/events_progress_map/model/events_progress_map_args.dart';
import 'package:locals/features/explore/restaurant_view_details/model/restaurant_view_details_args.dart';
import 'package:locals/shared/components/pin_details_sheet.dart';
import 'package:locals/shared/model/map_pin_details.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import '../../filters/model/filters_model.dart';
import '../../search/repository/map_search_repository.dart';
import '../model/map_screen_args.dart';
import '../model/map_model.dart';
import '../repository/map_repository.dart';

class MapController extends ChangeNotifier {
  final MapRepository repo;
  MapModel state;

  Timer? _searchDebounce;

  MapController(this.repo, {MapScreenArgs? screenArgs})
      : state = MapModel(
          activeMission: screenArgs?.mission?.toActiveMission(),
          selectedPinId: screenArgs?.focusedPinId,
          highlightedLocation: screenArgs?.highlightedLocation,
        ) {
    _loadPlaces();
  }

  // ─── Places Loading ─────────────────────────────────────────────────────────

  Future<void> _loadPlaces() async {
    state = state.copyWith(isLoadingPins: true);
    notifyListeners();

    try {
      final pins = await repo.fetchPlaces(
        search: state.searchQuery,
        categorySlug: _resolveCategorySlug(),
        placeType: _resolvePlaceType(),
        visitStatus: _resolveVisitStatus(),
      );
      state = state.copyWith(pins: pins, isLoadingPins: false);
    } catch (e) {
      print('Places fetch error: $e');
      state = state.copyWith(isLoadingPins: false);
    }

    notifyListeners();
  }

  String? _resolveCategorySlug() {
    final selected = state.filters.selectedCategoryIds;
    // API supports one category_slug at a time — use the first selected.
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

  // ─── Search & Filters ───────────────────────────────────────────────────────

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
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PinDetailsSheet(pin: details),
    );
  }

  void clearSelectedPin() {
    if (state.selectedPinId == null) return;
    state = state.copyWith(clearSelectedPin: true);
    notifyListeners();
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
      extra: FiltersArgs(
        initial: state.filters,
        onApply: applyFilters,
      ),
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
      extra: RestaurantViewDetailsArgs(
        locationId: location.resolvedLocationId,
      ),
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

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}