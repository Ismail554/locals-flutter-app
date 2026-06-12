import 'package:flutter/foundation.dart';
import '../model/saved_places_model.dart';
import '../repository/saved_places_repository.dart';

class SavedPlacesController extends ChangeNotifier {
  final SavedPlacesRepository repo;
  SavedPlacesModel state = const SavedPlacesModel();

  SavedPlacesController(this.repo);

  void removePlace(String id) {
    state = SavedPlacesModel(
      places: state.places.where((p) => p.id != id).toList(),
    );
    notifyListeners();
  }
}
