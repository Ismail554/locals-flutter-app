import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/network/token_manager.dart';

abstract class VerifyAccountOtpRepository {
  Future<void> verifyOtp({required String email, required String code});
}

class VerifyAccountOtpRepositoryImpl implements VerifyAccountOtpRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    final response = await _client.post('/auth/register/verify/', {
      'email': email,
      'code': code,
    });

    final access = response['access'] as String?;
    final refresh = response['refresh'] as String?;

    if (access == null || refresh == null) {
      throw const ApiException('Invalid response from server.');
    }

    await TokenManager().setTokens(access, refresh);
  }
}