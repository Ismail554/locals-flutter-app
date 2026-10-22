import 'package:flutter/foundation.dart';
import '../model/achievements_model.dart';
import '../repository/achievements_repository.dart';

class AchievementsController extends ChangeNotifier {
  final AchievementsRepository repo;
  AchievementsModel state = const AchievementsModel();

  bool isLoading = false;
  String? errorMessage;

  AchievementsController(this.repo) {
    _fetch();
  }

  Future<void> _fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      state = await repo.fetchAchievements();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => _fetch();
}