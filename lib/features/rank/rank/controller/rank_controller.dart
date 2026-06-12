import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/rank_model.dart';
import '../repository/rank_repository.dart';

class RankController extends ChangeNotifier {
  final RankRepository repo;
  RankModel state = const RankModel();

  RankController(this.repo);

  void selectScope(RankScope scope) {
    state = state.copyWith(selectedScope: scope);
    notifyListeners();
  }

  void selectPeriod(RankPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    notifyListeners();
  }

  void openViewProfile(BuildContext context) {
    context.push('/view_profile');
  }
}
