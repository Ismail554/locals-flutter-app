class MapSearchModel {
  final String query;
  final List<String> recentSearches;
  final List<String> trendingSearches;

  const MapSearchModel({
    this.query = '',
    this.recentSearches = const [],
    this.trendingSearches = const [],
  });

  MapSearchModel copyWith({
    String? query,
    List<String>? recentSearches,
    List<String>? trendingSearches,
  }) {
    return MapSearchModel(
      query: query ?? this.query,
      recentSearches: recentSearches ?? this.recentSearches,
      trendingSearches: trendingSearches ?? this.trendingSearches,
    );
  }
}
