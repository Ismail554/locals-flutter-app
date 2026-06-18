import 'package:flutter/material.dart';

class ApiLocale {
  ApiLocale._();

  static String acceptLanguageHeader(Locale? locale) {
    if (locale?.languageCode == 'es') return 'es';
    return 'en';
  }
}
