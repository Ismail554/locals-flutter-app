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

  MapController(this.repo, {MapScreenArgs? screenArgs})
      : state = MapModel(
          activeMission: screenArgs?.mission?.toActiveMission(),
          selectedPinId: screenArgs?.focusedPinId,
          highlightedLocation: screenArgs?.highlightedLocation,
        );

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value);
    notifyListeners();
  }

  void applyFilters(MapFiltersState filters) {
    state = state.copyWith(filters: filters);
    notifyListeners();
  }

void onPinTap(BuildContext context, String pinId) {
  print('✅ Pin tapped: $pinId');

  final pin = state.getPinById(pinId);
  if (pin == null) {
    print('❌ Pin not found: $pinId');
    return;
  }

  // Update selection state
  state = state.copyWith(
    selectedPinId: state.selectedPinId == pinId ? null : pinId,
  );
  notifyListeners();

  // Show Bottom Sheet
  _showPinDetailsBottomSheet(context, pin);
}

void _showPinDetailsBottomSheet(BuildContext context, MapPinInfo pin) {
  print('📍 Showing bottom sheet for: ${pin.name}');

  final details = MapPinDetails(
    id: pin.id,
    category: pin.category ?? 'PLACE',
    name: pin.name,
    address: pin.address ?? 'Unknown Address',
    points: pin.points ?? 30,
    accentColor: pin.accentColor ?? const Color(0xFFD4C4B0),
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => PinDetailsSheet(pin: details),
  ).then((_) {
    print('Bottom sheet closed');
  });
}

  void clearSelectedPin() {
    if (state.selectedPinId == null) return;
    state = state.copyWith(clearSelectedPin: true);
    notifyListeners();
  }

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
}