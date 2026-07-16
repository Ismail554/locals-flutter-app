import 'package:locals/core/network/api_client.dart';

import '../model/privacy_data_model.dart';

abstract class PrivacyDataRepository {
  Future<PrivacyDataModel> load();
  Future<void> deleteAccount();
}

class PrivacyDataRepositoryImpl implements PrivacyDataRepository {
  final ApiClient _client = ApiClient();
  @override
  Future<PrivacyDataModel> load() async => const PrivacyDataModel();

  @override
  Future<void> deleteAccount() async {
    try{
      await _client.delete('/auth/me/account/');
    } catch (e) {
      rethrow;
    }
  }
}
