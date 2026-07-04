import 'package:locals/core/network/api_client.dart';
import 'package:locals/features/explore/explore/model/explore_model.dart';
import '../model/featured_locations_model.dart';

abstract class FeaturedLocationsRepository {
  Future<FeaturedLocationsModel> load();
}

class FeaturedLocationsRepositoryImpl implements FeaturedLocationsRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<FeaturedLocationsModel> load() async {
    final response = await _client.get('/places/');
    final results = response['results'] as List? ?? [];

    final featured = results
        .map((item) => item as Map<String, dynamic>)
        .where((item) => item['is_featured'] == true)
        .map((item) => ExploreFeaturedLocation.fromApi(item))
        .toList();

    return FeaturedLocationsModel(locations: featured);
  }
}