import 'package:flutter/material.dart';
import 'app_locales.dart';
import 'locale_repository.dart';
import 'api_locale.dart'; // adjust import path

class LocaleController extends ChangeNotifier {
  final LocaleRepository _repository;

  Locale? _locale;

  LocaleController(this._repository);

  Locale? get locale => _locale;

  Future<void> loadLocale() async {
    final code = await _repository.loadLanguageCode();
    _locale = AppLocales.fromLanguageCode(code);
    ApiLocale.update(_locale); 
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (!AppLocales.supported.contains(locale)) return;
    _locale = locale;
    await _repository.saveLanguageCode(locale.languageCode);
    ApiLocale.update(_locale); 
    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = null;
    await _repository.clearLanguageCode();
    ApiLocale.update(_locale); 
    notifyListeners();
  }
}