import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/restaurant_view_details/model/restaurant_view_details_args.dart';
import '../model/saved_places_model.dart';
import '../repository/saved_places_repository.dart';

class SavedPlacesController extends ChangeNotifier {
  final SavedPlacesRepository repo;
  SavedPlacesModel state = const SavedPlacesModel();

  SavedPlacesController(this.repo);

  void openPlaceDetails(BuildContext context, SavedPlace place) {
    context.push(
      '/restaurant_view_details',
      extra: RestaurantViewDetailsArgs(locationId: place.id),
    );
  }

  void removePlace(String id) {
    state = SavedPlacesModel(
      places: state.places.where((p) => p.id != id).toList(),
    );
    notifyListeners();
  }
}
