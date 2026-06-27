import 'package:locals/core/network/api_client.dart';

abstract class SignupRepository {
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  });
}

class SignupRepositoryImpl implements SignupRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    await _client.post('/auth/register/', {
      'full_name': fullName,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    });
  }
}