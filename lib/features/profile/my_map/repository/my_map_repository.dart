import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import '../model/my_map_model.dart';

abstract class MyMapRepository {
  Future<MyMapModel> getPersonalMap();
}

class MyMapRepositoryImpl implements MyMapRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<MyMapModel> getPersonalMap() async {
    final dynamic response =
        await _client.get('/places/me/personal-map/?filter=all');

    List<dynamic> rawList = [];

    if (response is List) {
      rawList = response;
    } else if (response is Map) {
      final data = response['data'] ?? response['results'] ?? response['places'];
      if (data is List) {
        rawList = data;
      }
    }

    final pins = rawList.map((item) {
      final map = item as Map<String, dynamic>;
      final categorySlug = map['category_slug'] as String?;

      return MapPinInfo(
        id: map['place_id'].toString(),
        // Prefer a real name from the API if it's ever added to the
        // response; fall back to the category so pins aren't all
        // labeled "Visited Place" regardless of visited status.
        name: (map['name'] as String?) ??
            (categorySlug != null
                ? _titleCase(categorySlug)
                : 'Unknown Place'),
        level: 1,
        lat: double.tryParse(map['latitude'].toString()) ?? 0.0,
        lng: double.tryParse(map['longitude'].toString()) ?? 0.0,
        // Map the API's category_slug to the matching MapPinTag instead
        // of hardcoding MapPinTag.business for every pin. This assumes
        // MapPinTag's enum value names match the category_slug strings
        // coming back from the API (e.g. "mall" -> MapPinTag.mall).
        // If your enum names don't match 1:1, replace this with an
        // explicit switch/map from slug -> MapPinTag.
        tag: MapPinTag.values.firstWhere(
          (t) => t.name == categorySlug,
          orElse: () => MapPinTag.business,
        ),
        visited: map['is_visited'] as bool? ?? false,
        category: categorySlug,
      );
    }).toList();

    return MyMapModel(pins: pins);
  }

  String _titleCase(String slug) {
    if (slug.isEmpty) return slug;
    return slug
        .split('_')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}