import 'package:flutter/foundation.dart';

import '../model/my_map_model.dart';
import '../repository/my_map_repository.dart';

enum MyMapStatus {
  initial,
  loading,
  success,
  error,
}

class MyMapController extends ChangeNotifier {
  final MyMapRepository repo;

  MyMapModel state = const MyMapModel();

  MyMapStatus status = MyMapStatus.initial;

  String? errorMessage;

  MyMapController(this.repo) {
    loadPersonalMap();
  }

  Future<void> loadPersonalMap() async {
    status = MyMapStatus.loading;
    errorMessage = null;

    notifyListeners();

    try {
      final result = await repo.getPersonalMap();

      state = result;

      status = MyMapStatus.success;
    } catch (e, stackTrace) {
      debugPrint(
        '[MyMapController] Load error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      status = MyMapStatus.error;

      errorMessage = 'Unable to load your map.';
    }

    notifyListeners();
  }

  void selectFilter(
    MyMapFilter filter,
  ) {
    state = state.copyWith(
      selectedFilter: filter,
      clearSelectedPin: true,
    );

    notifyListeners();
  }

  void onPinTap(
    String pinId,
  ) {
    state = state.copyWith(
      selectedPinId:
          state.selectedPinId == pinId
              ? null
              : pinId,
    );

    notifyListeners();
  }

  void clearSelectedPin() {
    if (state.selectedPinId == null) {
      return;
    }

    state = state.copyWith(
      clearSelectedPin: true,
    );

    notifyListeners();
  }
}