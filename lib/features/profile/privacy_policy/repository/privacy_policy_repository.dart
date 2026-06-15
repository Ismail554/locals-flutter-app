import '../model/privacy_policy_model.dart';

abstract class PrivacyPolicyRepository {
  Future<PrivacyPolicyModel> load();
}

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  @override
  Future<PrivacyPolicyModel> load() async => const PrivacyPolicyModel();
}
