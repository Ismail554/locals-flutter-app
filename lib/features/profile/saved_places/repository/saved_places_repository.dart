import 'package:locals/core/network/api_client.dart';
import '../model/saved_places_model.dart';

abstract class SavedPlacesRepository {
  Future<SavedPlacesModel> getSavedPlaces();
}

class SavedPlacesRepositoryImpl implements SavedPlacesRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<SavedPlacesModel> getSavedPlaces() async {
    final response = await _client.get('/places/me/saved/?page=1');

    final results = response['results'] as List<dynamic>? ?? [];

    final places = results.map((item) {
      return SavedPlace.fromApi(item as Map<String, dynamic>);
    }).toList();

    return SavedPlacesModel(places: places);
  }
}