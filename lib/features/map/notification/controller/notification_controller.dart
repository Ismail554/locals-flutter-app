import 'package:flutter/foundation.dart';

import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

class NotificationController extends ChangeNotifier {
  final NotificationRepository repo;

  NotificationController(this.repo) {
    loadNotifications();
  }

  NotificationModel state = const NotificationModel();

  bool isLoading = false;
  bool isLoadingMore = false;
  String? error;

  int _currentPage = 1;

  bool get hasMore => state.hasNextPage;

  Future<void> loadNotifications({bool refresh = false}) async {
    try {
      if (refresh) {
        _currentPage = 1;
      }

      isLoading = true;
      error = null;
      notifyListeners();

      final response = await repo.getNotifications(page: _currentPage);

      state = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    try {
      isLoadingMore = true;
      notifyListeners();

      _currentPage++;

      final response = await repo.getNotifications(page: _currentPage);

      state = state.copyWith(
        count: response.count,
        next: response.next,
        previous: response.previous,
        items: [
          ...state.items,
          ...response.items,
        ],
      );
    } catch (e) {
      _currentPage--;
      debugPrint(e.toString());
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadNotifications(refresh: true);
  }

  Future<void> markRead(String id) async {
    try {
      await repo.markAsRead(id);

      state = state.copyWith(
        items: state.items.map((item) {
          if (item.id == id) {
            return item.copyWith(isRead: true);
          }
          return item;
        }).toList(),
      );

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> markAllRead() async {
    final unread = state.items.where((e) => !e.isRead);

    for (final item in unread) {
      await markRead(item.id);
    }
  }
}