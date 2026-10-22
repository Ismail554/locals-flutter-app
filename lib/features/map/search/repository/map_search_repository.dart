import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/model/map_pin_info.dart';

abstract class MapSearchRepository {
  List<String> loadRecentSearches();
  List<String> loadTrendingSearches();
  void addRecentSearch(String query);
  Future<List<MapPinInfo>> searchPlaces(String query);   // ← New
}

class MapSearchRepositoryImpl implements MapSearchRepository {
  MapSearchRepositoryImpl._();
  static final MapSearchRepositoryImpl instance = MapSearchRepositoryImpl._();
  factory MapSearchRepositoryImpl() => instance;

  final List<String> _recentSearches = [];

  static const _trendingSearches = <String>[
  ];

  final ApiClient _client = ApiClient();

  @override
  List<String> loadRecentSearches() => List.unmodifiable(_recentSearches);

  @override
  List<String> loadTrendingSearches() => List.unmodifiable(_trendingSearches);

  @override
  void addRecentSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    _recentSearches.remove(trimmed);
    _recentSearches.insert(0, trimmed);
    if (_recentSearches.length > 5) {
      _recentSearches.removeLast();
    }
  }

  @override
  Future<List<MapPinInfo>> searchPlaces(String query) async {
    final response = await _client.get('/places/?search=${Uri.encodeQueryComponent(query)}');
    final results = response['results'] as List? ?? [];
    
    return results
        .map((item) => MapPinInfo.fromApi(item as Map<String, dynamic>))
        .toList();
  }
}