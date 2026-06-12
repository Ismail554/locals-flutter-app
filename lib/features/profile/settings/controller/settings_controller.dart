import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/settings_model.dart';
import '../repository/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  final SettingsRepository repo;
  SettingsModel state = const SettingsModel();

  SettingsController(this.repo);

  void handleItemTap(BuildContext context, String itemId) {
    switch (itemId) {
      case 'notification':
        context.push('/set_notification');
      case 'privacy':
        context.push('/privacy');
      case 'manage_subscription':
        context.push('/manage_subscription');
      case 'logout':
        context.go('/login');
      case 'delete_account':
        _showDeleteDialog(context);
      default:
        break;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete account'),
        content: const Text(
          'This action cannot be undone. Are you sure you want to delete your account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
