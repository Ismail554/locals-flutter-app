import 'package:flutter/foundation.dart';
import '../model/achievements_model.dart';
import '../repository/achievements_repository.dart';

class AchievementsController extends ChangeNotifier {
  final AchievementsRepository repo;
  AchievementsModel state = const AchievementsModel();

  AchievementsController(this.repo);
}
