import 'package:locals/core/network/api_client.dart';

abstract class RequestOtpRepository {
  Future<void> requestPasswordReset({required String email});
}

class RequestOtpRepositoryImpl implements RequestOtpRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<void> requestPasswordReset({required String email}) async {
    await _client.post('/auth/password-reset/request/', {'email': email});
  }
}