class MapSearchModel {
  final String query;
  final List<String> recentSearches;
  final List<String> trendingSearches;

  const MapSearchModel({
    this.query = '',
    this.recentSearches = const [
      'Bunkers del Carmel',
      'Café del Born',
      'Vermouth',
    ],
    this.trendingSearches = const [
      'Sant Antoni',
      'Modernist',
      'Sunset spots',
      'Tapas',
      'Vermouth bars',
    ],
  });

  MapSearchModel copyWith({String? query}) {
    return MapSearchModel(
      query: query ?? this.query,
      recentSearches: recentSearches,
      trendingSearches: trendingSearches,
    );
  }
}
