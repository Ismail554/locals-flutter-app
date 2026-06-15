import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/featured_locations_model.dart';
import '../repository/featured_locations_repository.dart';
import '../../restaurant_view_details/model/restaurant_view_details_args.dart';

class FeaturedLocationsController extends ChangeNotifier {
  final FeaturedLocationsRepository repo;
  FeaturedLocationsModel state;

  FeaturedLocationsController(this.repo) : state = repo.load();

  void openLocation(BuildContext context, String locationId) {
    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: locationId),
    );
  }
}
