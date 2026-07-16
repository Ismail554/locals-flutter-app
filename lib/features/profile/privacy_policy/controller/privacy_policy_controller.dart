import 'package:flutter/material.dart';
import '../model/privacy_policy_model.dart';
import '../repository/privacy_policy_repository.dart';

class PrivacyPolicyController extends ChangeNotifier {
  final PrivacyPolicyRepository repo;
  PrivacyPolicyModel state = PrivacyPolicyModel();

  bool isLoading = true;

  PrivacyPolicyController(this.repo) {
    load();
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();

    try {
      state = await repo.load();
    } catch (e) {
      debugPrint('Privacy policy load error: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}