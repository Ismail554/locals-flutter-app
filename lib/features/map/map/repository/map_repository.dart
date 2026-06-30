import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/model/map_pin_info.dart';

abstract class MapRepository {
  Future<List<MapPinInfo>> fetchPlaces({
    String? search,
    String? categorySlug,
    String? placeType,
    String? visitStatus,
  });
}

class MapRepositoryImpl implements MapRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<List<MapPinInfo>> fetchPlaces({
    String? search,
    String? categorySlug,
    String? placeType,
    String? visitStatus,
  }) async {
    final params = <String, String>{
      if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      if (categorySlug != null) 'category_slug': categorySlug,
      if (placeType != null) 'place_type': placeType,
      if (visitStatus != null) 'visit_status': visitStatus,
    };

    final query = params.isEmpty
        ? ''
        : '?${params.entries.map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}').join('&')}';

    final response = await _client.get('/places/$query');
    final results = response['results'] as List? ?? [];
    return results
        .map((item) => MapPinInfo.fromApi(item as Map<String, dynamic>))
        .toList();
  }
}