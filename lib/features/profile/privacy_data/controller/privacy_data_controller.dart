import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/components/premium_confirm_dialog.dart';
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

  Future<void> confirmDeleteAccount(BuildContext context) async {
    final shouldDelete = await PremiumConfirmDialog.showDeleteAccount(context);
    if (!shouldDelete || !context.mounted) return;

    await repo.deleteAccount();
    if (!context.mounted) return;
    context.go('/login');
  }
}
