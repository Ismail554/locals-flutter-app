import 'package:flutter/material.dart';

import 'app_locales.dart';
import 'locale_repository.dart';

class LocaleController extends ChangeNotifier {
  final LocaleRepository _repository;

  Locale? _locale;

  LocaleController(this._repository);

  Locale? get locale => _locale;

  String get acceptLanguageHeader {
    final code = _locale?.languageCode;
    if (code == 'es') return 'es';
    return 'en';
  }

  Future<void> loadLocale() async {
    final code = await _repository.loadLanguageCode();
    _locale = AppLocales.fromLanguageCode(code);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!AppLocales.supported.contains(locale)) return;
    _locale = locale;
    await _repository.saveLanguageCode(locale.languageCode);
    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = null;
    await _repository.clearLanguageCode();
    notifyListeners();
  }
}
