import 'package:flutter/foundation.dart';
import '../model/list_model.dart';
import '../repository/list_repository.dart';

class ListController extends ChangeNotifier {
  final ListRepository repo;
  ListModel state = const ListModel();

  ListController(this.repo);

  void selectTab(ListTab tab) {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();
  }

  void toggleFollow(String id) {
    if (state.selectedTab == ListTab.followers) {
      state = state.copyWith(
        followers: state.followers
            .map((u) => u.id == id ? u.copyWith(isFollowing: !u.isFollowing) : u)
            .toList(),
      );
    } else {
      state = state.copyWith(
        following: state.following
            .map((u) => u.id == id ? u.copyWith(isFollowing: !u.isFollowing) : u)
            .toList(),
      );
    }
    notifyListeners();
  }
}
