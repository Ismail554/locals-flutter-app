import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/featured_locations_model.dart';
import '../repository/featured_locations_repository.dart';
import '../../restaurant_view_details/model/restaurant_view_details_args.dart';

class FeaturedLocationsController extends ChangeNotifier {
  final FeaturedLocationsRepository repo;
  FeaturedLocationsModel state = const FeaturedLocationsModel(isLoading: true);

  FeaturedLocationsController(this.repo) {
    _load();
  }

  Future<void> _load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      state = await repo.load();
    } catch (e) {
      print('Featured locations load error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load locations. Please try again.',
      );
    }

    notifyListeners();
  }

  Future<void> refresh() => _load();

  void openLocation(BuildContext context, String locationId) {
    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: locationId),
    );
  }
}