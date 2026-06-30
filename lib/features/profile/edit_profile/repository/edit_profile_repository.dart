import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/network/token_manager.dart';
import 'package:locals/core/network/user_session.dart';
import '../model/edit_profile_model.dart';

abstract class EditProfileRepository {
  Future<EditProfileModel> load();
  Future<void> saveProfile({
    required String name,
    required String location,
    String? avatarImagePath,
  });
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class EditProfileRepositoryImpl implements EditProfileRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<EditProfileModel> load() async {
    var user = UserSession().currentUser;
    user ??= await UserSession().fetchCurrentUser();

    if (user == null) {
      return const EditProfileModel();
    }

    return EditProfileModel(
      name: user.fullName,
      location: user.locationCity,
      avatarUrl: user.avatarUrl,
    );
  }

  @override
  Future<void> saveProfile({
    required String name,
    required String location,
    String? avatarImagePath,
  }) async {
    final hasNewAvatar =
        avatarImagePath != null && File(avatarImagePath).existsSync();

    if (hasNewAvatar) {
      await _saveWithAvatar(
        name: name,
        location: location,
        avatarImagePath: avatarImagePath,
      );
    } else {
      // No new image — plain JSON PATCH is sufficient
      await _client.patch('/auth/me/', {
        'full_name': name,
        'location_city': location,
      });
    }

    // Refresh cached user so the change is visible app-wide immediately
    await UserSession().fetchCurrentUser();
  }

  Future<void> _saveWithAvatar({
    required String name,
    required String location,
    required String avatarImagePath,
  }) async {
    final token = await TokenManager().accessToken;

    // ApiClient.baseUrl already includes /api/v1 — do NOT append it again here.
    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse('${ApiClient.baseUrl}/auth/me/'),
    );

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields['full_name'] = name;
    request.fields['location_city'] = location;
    request.files.add(
      await http.MultipartFile.fromPath('avatar', avatarImagePath),
    );

    print('');
    print('┌─── API REQUEST ───────────────────────────────────');
    print('│ PATCH ${request.url} (multipart, avatar upload)');
    print('│ Fields: full_name=$name, location_city=$location');
    print('│ File: $avatarImagePath');
    print('└────────────────────────────────────────────────────');

    final streamed =
        await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamed);
    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    print('');
    print(
      '┌─── API RESPONSE ${isSuccess ? "✅" : "❌"} ─────────────────────────────',
    );
    print('│ Status: ${response.statusCode}');
    print('│ Body: ${response.body}');
    print('└────────────────────────────────────────────────────');

    if (!isSuccess) {
      throw const ApiException('Failed to update profile. Please try again.');
    }
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _client.post('/auth/me/change-password/', {
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirm_password': newPassword,
      });
      return true;
    } on ApiException catch (e) {
      print('Change password error: ${e.message}');
      return false;
    }
  }
}