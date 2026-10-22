import 'package:locals/core/network/api_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/shared/model/map_pin_info.dart';

abstract class MapRepository {
  Future<List<MapPinInfo>> fetchPlaces({
    String? search,
    String? categorySlug,
    String? placeType,
    String? visitStatus,
    LatLngBounds? bounds,
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
    LatLngBounds? bounds,
  }) async {
    final params = <String, String>{
      if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      if (categorySlug != null) 'category_slug': categorySlug,
      if (placeType != null) 'place_type': placeType,
      if (visitStatus != null) 'visit_status': visitStatus,
      if (bounds != null) ...{
        'min_lat': bounds.southwest.latitude.toString(),
        'min_lng': bounds.southwest.longitude.toString(),
        'max_lat': bounds.northeast.latitude.toString(),
        'max_lng': bounds.northeast.longitude.toString(),
      },
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
