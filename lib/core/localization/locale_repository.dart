import 'package:shared_preferences/shared_preferences.dart';

abstract class LocaleRepository {
  Future<String?> loadLanguageCode();
  Future<void> saveLanguageCode(String languageCode);
  Future<void> clearLanguageCode();
}

class LocaleRepositoryImpl implements LocaleRepository {
  static const storageKey = 'app_locale';

  final SharedPreferences _prefs;

  LocaleRepositoryImpl(this._prefs);

  @override
  Future<String?> loadLanguageCode() async {
    return _prefs.getString(storageKey);
  }

  @override
  Future<void> saveLanguageCode(String languageCode) async {
    await _prefs.setString(storageKey, languageCode);
  }

  @override
  Future<void> clearLanguageCode() async {
    await _prefs.remove(storageKey);
  }
}
