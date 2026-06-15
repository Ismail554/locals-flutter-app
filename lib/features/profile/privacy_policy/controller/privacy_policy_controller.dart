import 'package:flutter/foundation.dart';
import '../model/privacy_policy_model.dart';
import '../repository/privacy_policy_repository.dart';

class PrivacyPolicyController extends ChangeNotifier {
  final PrivacyPolicyRepository repo;
  PrivacyPolicyModel state = const PrivacyPolicyModel();

  PrivacyPolicyController(this.repo);

  Future<void> load() async {
    state = await repo.load();
    notifyListeners();
  }
}
