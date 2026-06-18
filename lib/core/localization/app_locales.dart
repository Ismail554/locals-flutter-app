import 'package:flutter/material.dart';
import 'package:locals/l10n/app_localizations.dart';

class AppLocales {
  AppLocales._();

  static const Locale en = Locale('en');
  static const Locale es = Locale('es');

  static const List<Locale> supported = [en, es];

  static const Map<String, String> displayNames = {
    'en': 'English',
    'es': 'Spanish',
  };

  static String displayNameFor(Locale locale) {
    return displayNames[locale.languageCode] ?? displayNames['en']!;
  }

  static String displayNameForCode(String languageCode) {
    return displayNames[languageCode] ?? displayNames['en']!;
  }

  static String localizedDisplayName(AppLocalizations l10n, Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return l10n.languageSpanish;
      default:
        return l10n.languageEnglish;
    }
  }

  static Locale? fromLanguageCode(String? languageCode) {
    if (languageCode == null) return null;
    for (final locale in supported) {
      if (locale.languageCode == languageCode) {
        return locale;
      }
    }
    return null;
  }
}
