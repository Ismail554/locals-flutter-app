import 'package:locals/shared/model/map_pin_info.dart';

class MapSearchModel {
  final String query;
  final List<String> recentSearches;
  final List<String> trendingSearches;
  final List<MapPinInfo> searchResults;   // ← New

  const MapSearchModel({
    this.query = '',
    this.recentSearches = const [],
    this.trendingSearches = const [],
    this.searchResults = const [],
  });

  MapSearchModel copyWith({
    String? query,
    List<String>? recentSearches,
    List<String>? trendingSearches,
    List<MapPinInfo>? searchResults,
  }) {
    return MapSearchModel(
      query: query ?? this.query,
      recentSearches: recentSearches ?? this.recentSearches,
      trendingSearches: trendingSearches ?? this.trendingSearches,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}