import 'package:flutter/material.dart';

class ApiLocale {
  ApiLocale._();
  static String _currentLanguageCode = 'en';

  static String get current => _currentLanguageCode;
  static void update(Locale? locale) {
    _currentLanguageCode = acceptLanguageHeader(locale);
  }

  static String acceptLanguageHeader(Locale? locale) {
    if (locale?.languageCode == 'es') return 'es';
    return 'en';
  }
}