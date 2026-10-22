import 'package:locals/core/network/api_client.dart';

abstract class PrivacyRepository {
  Future<Map<String, dynamic>> loadSettings();

  Future<Map<String, dynamic>> updateSettings(Map<String, dynamic> settings);
}

class PrivacyRepositoryImpl implements PrivacyRepository {
  final ApiClient _client;

  PrivacyRepositoryImpl({ApiClient? client}) : _client = client ?? ApiClient();

  @override
  Future<Map<String, dynamic>> loadSettings() {
    return _client.get('/auth/me/settings/');
  }

  @override
  Future<Map<String, dynamic>> updateSettings(Map<String, dynamic> settings) {
    return _client.patch('/auth/me/settings/', settings);
  }
}
