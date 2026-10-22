import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/map_search_model.dart';
import '../repository/map_search_repository.dart';

class MapSearchController extends ChangeNotifier {
  final MapSearchRepository repo;
  MapSearchModel state;

  MapSearchController(this.repo, {String initialQuery = ''})
      : state = MapSearchModel(
          query: initialQuery,
          recentSearches: repo.loadRecentSearches(),
          trendingSearches: repo.loadTrendingSearches(),
          searchResults: [], // Start empty
        );

  void setQuery(String value) {
    state = state.copyWith(query: value);
    notifyListeners();

    if (value.trim().length > 1) {
      _performSearch(value.trim());
    } else {
      state = state.copyWith(searchResults: []);
      notifyListeners();
    }
  }

  Future<void> _performSearch(String query) async {
    try {
      final results = await repo.searchPlaces(query);
      state = state.copyWith(searchResults: results);
      notifyListeners();
    } catch (e) {
      debugPrint("Search error: $e");
      state = state.copyWith(searchResults: []);
      notifyListeners();
    }
  }

  void selectSuggestion(BuildContext context, String value) {
    repo.addRecentSearch(value);
    context.pop(value);
  }

  void cancel(BuildContext context) {
    context.pop();
  }
}