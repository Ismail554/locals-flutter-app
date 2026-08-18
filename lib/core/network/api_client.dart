import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:locals/core/localization/api_locale.dart';
import 'token_manager.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  static final baseUrl = dotenv.env['base_url'] ?? '';
  // static const _apiPrefix = '/api/v1';

  ApiClient._internal();

  static const Duration _timeout = Duration(seconds: 30);

  Map<String, String> get _baseHeaders => {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Accept-Language': ApiLocale.current,
  };

  Future<Map<String, String>> get _authHeaders async {
    final token = await TokenManager().accessToken;
    return {
      ..._baseHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    bool requiresAuth = true,
  }) async {
    final url = '$baseUrl$path';

    try {
      final headers = requiresAuth ? await _authHeaders : _baseHeaders;

      _logRequest('POST', url, body);

      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(_timeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      _logError('POST', url, 'No internet connection');
      throw const ApiException('No internet connection.');
    } on HttpException {
      _logError('POST', url, 'Network error');
      throw const ApiException('Network error. Please try again.');
    } on FormatException {
      _logError('POST', url, 'Unexpected response format');
      throw const ApiException('Unexpected response format.');
    } on TimeoutException {
      _logError('POST', url, 'Request timed out');
      throw const ApiException('No internet connection. Please try again.');
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    bool requiresAuth = true,
  }) async {
    final url = '$baseUrl$path';

    try {
      final headers = requiresAuth ? await _authHeaders : _baseHeaders;

      _logRequest('GET', url, null);

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(_timeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      _logError('GET', url, 'No internet connection');
      throw const ApiException('No internet connection.');
    } on HttpException {
      _logError('GET', url, 'Network error');
      throw const ApiException('Network error. Please try again.');
    } on FormatException {
      _logError('GET', url, 'Unexpected response format');
      throw const ApiException('Unexpected response format.');
    } on TimeoutException {
      _logError('GET', url, 'Request timed out');
      throw const ApiException('No internet connection. Please try again.');
    }
  }

  Future<Map<String, dynamic>> patch(
    String path,
    Map<String, dynamic> body, {
    bool requiresAuth = true,
  }) async {
    final url = '$baseUrl$path';

    try {
      final headers = requiresAuth ? await _authHeaders : _baseHeaders;

      _logRequest('PATCH', url, body);

      final response = await http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(_timeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      _logError('PATCH', url, 'No internet connection');
      throw const ApiException('No internet connection.');
    } on HttpException {
      _logError('PATCH', url, 'Network error');
      throw const ApiException('Network error. Please try again.');
    } on FormatException {
      _logError('PATCH', url, 'Unexpected response format');
      throw const ApiException('Unexpected response format.');
    } on TimeoutException {
      _logError('PATCH', url, 'Request timed out');
      throw const ApiException('No internet connection. Please try again.');
    }
  }

  // Add this method inside ApiClient, near post()/get()/patch()

  Future<Map<String, dynamic>> postMultipart(
    String path, {
    required Map<String, String> fields,
    required Map<String, File> files,
    bool requiresAuth = true,
  }) async {
    final url = '$baseUrl$path';

    try {
      final authHeaders = requiresAuth ? await _authHeaders : _baseHeaders;
      final headers = Map<String, String>.from(authHeaders)
        ..remove('Content-Type');

      _logRequest('POST (multipart)', url, fields);

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields.addAll(fields);

      for (final entry in files.entries) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, entry.value.path),
        );
      }

      final streamed = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamed);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      _logError('POST', url, 'No internet connection');
      throw const ApiException('No internet connection.');
    } on HttpException {
      _logError('POST', url, 'Network error');
      throw const ApiException('Network error. Please try again.');
    } on FormatException {
      _logError('POST', url, 'Unexpected response format');
      throw const ApiException('Unexpected response format.');
    } on TimeoutException {
      _logError('POST', url, 'Request timed out');
      throw const ApiException('No internet connection. Please try again.');
    }
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    bool requiresAuth = true,
  }) async {
    final url = '$baseUrl$path';

    try {
      final headers = requiresAuth ? await _authHeaders : _baseHeaders;

      _logRequest('DELETE', url, null);

      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(_timeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      _logError('DELETE', url, 'No internet connection');
      throw const ApiException('No internet connection.');
    } on HttpException {
      _logError('DELETE', url, 'Network error');
      throw const ApiException('Network error. Please try again.');
    } on FormatException {
      _logError('DELETE', url, 'Unexpected response format');
      throw const ApiException('Unexpected response format.');
    } on TimeoutException {
      _logError('DELETE', url, 'Request timed out');
      throw const ApiException('No internet connection. Please try again.');
    }
  }

  // ─── Logging ────────────────────────────────────────────────────────────────

  void _logRequest(String method, String url, Map<String, dynamic>? body) {
    print('');
    print('┌─── API REQUEST ───────────────────────────────────');
    print('│ $method $url');
    if (body != null) {
      final safeBody = Map<String, dynamic>.from(body);
      for (final key in ['password', 'confirm_password', 'new_password']) {
        if (safeBody.containsKey(key)) safeBody[key] = '••••••••';
      }
      print('│ Body: ${jsonEncode(safeBody)}');
    }
    print('└────────────────────────────────────────────────────');
  }

  void _logResponse(http.Response response) {
    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;
    final icon = isSuccess ? '✅' : '❌';

    print('');
    print('┌─── API RESPONSE $icon ─────────────────────────────');
    print('│ Status: ${response.statusCode}');
    print('│ Body: ${response.body}');
    print('└────────────────────────────────────────────────────');
  }

  void _logError(String method, String url, String error) {
    print('');
    print('┌─── API ERROR ❌ ───────────────────────────────────');
    print('│ $method $url');
    print('│ Error: $error');
    print('└────────────────────────────────────────────────────');
  }

  // ─── Response handling ──────────────────────────────────────────────────────

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = _decodeBody(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = _extractErrorMessage(body);
    throw ApiException(message, statusCode: response.statusCode);
  }

  Map<String, dynamic> _decodeBody(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {'data': decoded};
    } catch (_) {
      return {};
    }
  }

  String _extractErrorMessage(Map<String, dynamic> body) {
    // Prefer specific field-level validation errors over a generic message.
    // e.g. {"message": "Validation failed.",
    //       "errors": {"non_field_errors": ["This password must ..."]}}
    final nested = _firstMessageFromValue(body['errors']);
    if (nested != null) return nested;

    if (body['detail'] is String) return body['detail'] as String;
    if (body['message'] is String) return body['message'] as String;

    for (final entry in body.entries) {
      final value = entry.value;
      if (value is List && value.isNotEmpty) {
        return value.first.toString();
      }
      if (value is String) return value;
    }

    return 'Something went wrong. Please try again.';
  }

  /// Recursively pulls the first human-readable message out of a DRF-style
  /// error payload, which may be a String, a List, or a nested Map of them.
  String? _firstMessageFromValue(dynamic value) {
    if (value is String) {
      return value.trim().isEmpty ? null : value;
    }
    if (value is List) {
      for (final item in value) {
        final msg = _firstMessageFromValue(item);
        if (msg != null) return msg;
      }
    }
    if (value is Map) {
      for (final item in value.values) {
        final msg = _firstMessageFromValue(item);
        if (msg != null) return msg;
      }
    }
    return null;
  }
}
