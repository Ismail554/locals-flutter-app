import 'package:locals/core/network/api_client.dart';
import '../model/privacy_policy_model.dart';

abstract class PrivacyPolicyRepository {
  Future<PrivacyPolicyModel> load();
}

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<PrivacyPolicyModel> load() async {
    final response = await _client.get('/explore/legal/privacy-policy/');
    return PrivacyPolicyModel.fromJson(response);
  }
}