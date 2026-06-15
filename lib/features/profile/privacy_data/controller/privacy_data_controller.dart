import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/privacy_data_model.dart';
import '../repository/privacy_data_repository.dart';

class PrivacyDataController extends ChangeNotifier {
  final PrivacyDataRepository repo;
  PrivacyDataModel state = const PrivacyDataModel();

  PrivacyDataController(this.repo);

  Future<void> load() async {
    state = await repo.load();
    notifyListeners();
  }

  void openPrivacyPolicy(BuildContext context) {
    context.push('/privacy_policy');
  }

  void openTermsOfUse(BuildContext context) {
    context.push('/terms_of_use');
  }

  void confirmDeleteAccount(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete account'),
        content: const Text(
          'This action cannot be undone. Are you sure you want to delete your account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await repo.deleteAccount();
              if (!context.mounted) return;
              context.go('/login');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
