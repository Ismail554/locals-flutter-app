import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/events_progress_map/model/events_progress_map_args.dart';
import 'package:locals/features/explore/restaurant_view_details/model/restaurant_view_details_args.dart';
import '../../filters/model/filters_model.dart';
import '../model/map_mission_args.dart';
import '../model/map_model.dart';
import '../repository/map_repository.dart';

class MapController extends ChangeNotifier {
  final MapRepository repo;
  MapModel state;

  MapController(this.repo, {MapMissionArgs? missionArgs})
      : state = MapModel(
          activeMission: missionArgs?.toActiveMission(),
        );

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value);
    notifyListeners();
  }

  void applyFilters(MapFiltersState filters) {
    state = state.copyWith(filters: filters);
    notifyListeners();
  }

  Future<void> openSearch(BuildContext context) async {
    final result = await context.push<String>(
      '/map_search',
      extra: state.searchQuery,
    );
    if (result != null && result.trim().isNotEmpty) {
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
    final location = state.activeMission?.activeLocation;
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
