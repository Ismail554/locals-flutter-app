import 'package:locals/core/network/api_client.dart';

abstract class SetNewPasswordRepository {
  Future<void> confirmPasswordReset({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}

class SetNewPasswordRepositoryImpl implements SetNewPasswordRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<void> confirmPasswordReset({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _client.post('/auth/password-reset/confirm/', {
      'email': email,
      'reset_token': resetToken,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    });
  }
}