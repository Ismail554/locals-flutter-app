import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/filters_model.dart';
import '../repository/filters_repository.dart';

class FiltersController extends ChangeNotifier {
  final FiltersRepository repo;
  final FiltersArgs? args;
  MapFiltersState state;

  FiltersController(this.repo, {this.args})
      : state = args?.initial ?? MapFiltersState.defaults;

  void toggleCategory(String id) {
    final selected = Set<String>.from(state.selectedCategoryIds);
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    state = state.copyWith(selectedCategoryIds: selected);
    notifyListeners();
  }

  void setPlaceType(PlaceTypeFilter value) {
    state = state.copyWith(placeType: value);
    notifyListeners();
  }

  void setVisitStatus(VisitStatusFilter value) {
    state = state.copyWith(visitStatus: value);
    notifyListeners();
  }

  void reset() {
    state = MapFiltersState.cleared;
    notifyListeners();
  }

  void apply(BuildContext context) {
    args?.onApply(state);
    context.pop(state);
  }
}
