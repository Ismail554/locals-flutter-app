import 'package:flutter/foundation.dart';
import '../model/blocked_list_model.dart';
import '../repository/blocked_list_repository.dart';

class BlockedListController extends ChangeNotifier {
  final BlockedListRepository repo;
  BlockedListModel state = const BlockedListModel();

  BlockedListController(this.repo);

  void unblock(String id) {
    state = state.copyWith(
      users: state.users.where((u) => u.id != id).toList(),
    );
    notifyListeners();
  }
}
