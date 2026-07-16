import 'package:flutter/foundation.dart';
import '../model/my_map_model.dart';
import '../repository/my_map_repository.dart';

class MyMapController extends ChangeNotifier {
  final MyMapRepository repo;
  MyMapModel state = const MyMapModel();

  MyMapController(this.repo) {
    _loadPersonalMap();
  }

  Future<void> _loadPersonalMap() async {
    try {
      state = await repo.getPersonalMap();
    } catch (e) {
      debugPrint('My Map load error: $e');
    }
    notifyListeners();
  }

  void selectFilter(MyMapFilter filter) {
    state = state.copyWith(selectedFilter: filter, clearSelectedPin: true);
    notifyListeners();
  }

  void onPinTap(String pinId) {
    state = state.copyWith(
      selectedPinId: state.selectedPinId == pinId ? null : pinId,
    );
    notifyListeners();
  }

  void clearSelectedPin() {
    if (state.selectedPinId == null) return;
    state = state.copyWith(clearSelectedPin: true);
    notifyListeners();
  }
}