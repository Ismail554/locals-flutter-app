
import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/network/token_manager.dart';

abstract class LoginRepository {
  Future<void> login({required String email, required String password});
}

class LoginRepositoryImpl implements LoginRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post('/auth/login/', {
      'email': email,
      'password': password,
    });

    final access = response['access'] as String?;
    final refresh = response['refresh'] as String?;

    if (access == null || refresh == null) {
      throw const ApiException('Invalid response from server.');
    }

    await TokenManager().setTokens(access, refresh);
  }
}