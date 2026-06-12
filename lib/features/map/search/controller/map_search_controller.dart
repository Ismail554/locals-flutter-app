import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/map_search_model.dart';
import '../repository/map_search_repository.dart';

class MapSearchController extends ChangeNotifier {
  final MapSearchRepository repo;
  MapSearchModel state;

  MapSearchController(this.repo, {String initialQuery = ''})
      : state = MapSearchModel(query: initialQuery);

  void setQuery(String value) {
    state = state.copyWith(query: value);
    notifyListeners();
  }

  void selectSuggestion(BuildContext context, String value) {
    context.pop(value);
  }

  void cancel(BuildContext context) {
    context.pop();
  }
}
