import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() => _instance;

  TokenManager._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<String?> get accessToken async {
    if (_prefs == null) await init();
    return _prefs?.getString('access_token');
  }

  Future<String?> get refreshToken async {
    if (_prefs == null) await init();
    return _prefs?.getString('refresh_token');
  }

  Future<bool> get hasToken async {
    final token = await accessToken;
    return token != null && token.isNotEmpty;
  }

  Future<void> setTokens(String access, String refresh) async {
    if (_prefs == null) await init();
    await _prefs?.setString('access_token', access);
    await _prefs?.setString('refresh_token', refresh);
  }

  Future<void> clearTokens() async {
    if (_prefs == null) await init();
    await _prefs?.remove('access_token');
    await _prefs?.remove('refresh_token');
  }
}