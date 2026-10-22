import 'package:locals/core/network/api_client.dart';

abstract class VerifyOtpRepository {
  Future<String> verifyOtp({required String email, required String code});
  Future<void> resendOtp({required String email});
}

class VerifyOtpRepositoryImpl implements VerifyOtpRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<String> verifyOtp({
    required String email,
    required String code,
  }) async {
    final response = await _client.post('/auth/password-reset/verify/', {
      'email': email,
      'code': code,
    });

    final resetToken = response['reset_token'] as String?;
    if (resetToken == null) {
      throw const ApiException('Invalid response from server.');
    }

    return resetToken;
  }

  @override
  Future<void> resendOtp({required String email}) async {
    await _client.post('/auth/password-reset/request/', {'email': email});
  }
}
