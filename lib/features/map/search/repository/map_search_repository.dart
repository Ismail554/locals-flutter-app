abstract class MapSearchRepository {
  List<String> loadRecentSearches();
  List<String> loadTrendingSearches();
  void addRecentSearch(String query);
}

class MapSearchRepositoryImpl implements MapSearchRepository {
  MapSearchRepositoryImpl._();
  static final MapSearchRepositoryImpl instance = MapSearchRepositoryImpl._();
  factory MapSearchRepositoryImpl() => instance;

  final List<String> _recentSearches = [];

  static const _trendingSearches = [
    'Sant Antoni',
    'Modernist',
    'Sunset spots',
    'Tapas',
    'Vermouth bars',
  ];

  @override
  List<String> loadRecentSearches() => List.unmodifiable(_recentSearches);

  @override
  List<String> loadTrendingSearches() => _trendingSearches;

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
}
