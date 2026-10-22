import 'package:flutter/material.dart';
import '../model/blocked_list_model.dart';
import '../repository/blocked_list_repository.dart';

class BlockedListController extends ChangeNotifier {
  final BlockedListRepository repo;
  BlockedListModel state = const BlockedListModel(isLoading: true);

  BlockedListController(this.repo) {
    _loadBlocked();
  }

  Future<void> _loadBlocked() async {
    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      final users = await repo.fetchBlocked();
      state = state.copyWith(users: users, isLoading: false);
    } catch (e) {
      print('Blocked list load error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load blocked users. Please try again.',
      );
    }

    notifyListeners();
  }

  Future<void> refresh() => _loadBlocked();

  Future<void> unblock(String id) async {
    final removed = state.users.firstWhere((u) => u.id == id);

    // Optimistic removal
    state = state.copyWith(
      users: state.users.where((u) => u.id != id).toList(),
    );
    notifyListeners();

    try {
      await repo.unblock(id);
    } catch (e) {
      print('Unblock error: $e');
      // Rollback — re-insert the user
      state = state.copyWith(users: [...state.users, removed]);
      notifyListeners();
    }
  }
}