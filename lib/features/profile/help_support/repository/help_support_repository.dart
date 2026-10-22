import 'package:flutter/material.dart';
import 'package:locals/core/network/api_client.dart';
import '../model/help_support_model.dart';

abstract class HelpSupportRepository {
  Future<HelpSupportModel> load();
  Future<bool> sendSupportEmail({
    required String subject,
    required String message,
  });
}

class HelpSupportRepositoryImpl implements HelpSupportRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<HelpSupportModel> load() async {
    return const HelpSupportModel();
  }

  @override
  Future<bool> sendSupportEmail({
    required String subject,
    required String message,
  }) async {
    try {
      await _client.post('/explore/support/', {
        'subject': subject,
        'message': message,
      });
      return true;
    } catch (e) {
      debugPrint("Support email send failed: $e");
      return false;
    }
  }
}