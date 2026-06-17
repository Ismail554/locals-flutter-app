import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/components/premium_confirm_dialog.dart';
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
      case 'edit_profile':
        context.push('/edit_profile');
      // case 'manage_subscription':
      //   context.push('/manage_subscription');
      case 'help':
        context.push('/help_support');
      case 'policy':
        context.push('/privacy_data');
      case 'rate':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thanks for your feedback!')),
        );
      case 'logout':
        confirmLogout(context);
      default:
        break;
    }
  }

  Future<void> confirmLogout(BuildContext context) async {
    final shouldLogout = await PremiumConfirmDialog.showLogout(context);
    if (!shouldLogout || !context.mounted) return;
    context.go('/login');
  }
}
