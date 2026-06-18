# Localization guide

This document explains how localization is set up in Locals, which files you edit, and the day-to-day workflow for adding or changing translated UI text.

---

## Table of contents

1. [Design principles](#design-principles)
2. [File map](#file-map)
3. [Configuration](#configuration)
4. [ARB file format](#arb-file-format)
5. [Adding a new string](#adding-a-new-string)
6. [Using strings in code](#using-strings-in-code)
7. [Placeholders and parameters](#placeholders-and-parameters)
8. [Dynamic UI builders](#dynamic-ui-builders)
9. [Runtime language switching](#runtime-language-switching)
10. [Locale resolution order](#locale-resolution-order)
11. [API integration](#api-integration)
12. [Adding a new language](#adding-a-new-language)
13. [Troubleshooting](#troubleshooting)
14. [Checklist](#checklist)

---

## Design principles

| Principle | Detail |
|-----------|--------|
| **Static UI → ARB** | Labels, titles, buttons, hints, empty states, and static errors live in `app_en.arb` / `app_es.arb`. |
| **Dynamic data → API / models** | Place names, addresses, user names, story text, and server-driven content are **not** translated in the Flutter client. The backend should localize these when `Accept-Language` is sent. |
| **English is the template** | `app_en.arb` is the source of truth. New keys are added there first, then translated in `app_es.arb`. |
| **Generated code is read-only** | Never edit `app_localizations.dart` or `app_localizations_en.dart` / `_es.dart` by hand. |

---

## File map

```
project root/
├── l10n.yaml                          # Generator settings
├── pubspec.yaml                       # flutter: generate: true
│
lib/
├── l10n/
│   ├── app_en.arb                     # ✏️ English (template)
│   ├── app_es.arb                     # ✏️ Spanish
│   ├── app_localizations.dart         # 🤖 Generated entry point
│   ├── app_localizations_en.dart      # 🤖 Generated
│   └── app_localizations_es.dart      # 🤖 Generated
│
├── core/localization/
│   ├── app_locales.dart               # Supported locales, display names
│   ├── locale_controller.dart         # Active locale, setLocale(), notifyListeners
│   ├── locale_repository.dart         # SharedPreferences persistence
│   ├── l10n_extensions.dart           # context.l10n
│   ├── api_locale.dart                # Accept-Language for HTTP
│   ├── onboard_l10n.dart              # Onboarding page list from l10n
│   ├── settings_l10n.dart             # Settings sections from l10n
│   ├── filters_l10n.dart              # Map filter id → label
│   ├── notification_l10n.dart       # Notification type labels
│   └── privacy_l10n.dart              # Privacy option labels
│
├── core/startup/startup.dart          # Loads LocaleController at boot
├── app/app.dart                       # MaterialApp locale + delegates
└── features/profile/settings/
    └── view/widgets/language_picker_sheet.dart
```

---

## Configuration

### `l10n.yaml` (project root)

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
nullable-getter: false
```

| Setting | Meaning |
|---------|---------|
| `arb-dir` | Folder containing `.arb` files |
| `template-arb-file` | Master file; defines required keys |
| `output-class` | Generated class name (`AppLocalizations`) |
| `nullable-getter: false` | `AppLocalizations.of(context)` is non-nullable |

### `pubspec.yaml`

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any
  shared_preferences: ^2.5.3

flutter:
  generate: true
```

With `generate: true`, `flutter run` and `flutter build` invoke `gen-l10n` automatically.

---

## ARB file format

ARB (Application Resource Bundle) files are JSON. Each **message key** maps to a string value.

### Minimal example (`app_en.arb`)

```json
{
  "@@locale": "en",
  "commonCancel": "Cancel",
  "loginWelcomeTitle": "Welcome back"
}
```

### Matching Spanish (`app_es.arb`)

```json
{
  "@@locale": "es",
  "commonCancel": "Cancelar",
  "loginWelcomeTitle": "Bienvenido de nuevo"
}
```

### Key naming conventions

- Use **camelCase**: `settingsEditProfile`, `mapSearchHint`.
- Prefix by **feature or scope**: `login*`, `signup*`, `explore*`, `common*` (shared across screens).
- Keep keys **stable** — renaming a key requires updating all Dart references.
- Avoid embedding English sentences in key names; the key is an identifier, not the text.

---

## Adding a new string

### Step 1 — Add to English template

`lib/l10n/app_en.arb`:

```json
"restaurantDirections": "Directions",
```

### Step 2 — Add Spanish translation

`lib/l10n/app_es.arb`:

```json
"restaurantDirections": "Cómo llegar",
```

### Step 3 — Regenerate localizations

```bash
flutter gen-l10n
```

Or run / build the app (`flutter run`), which triggers generation when `generate: true`.

### Step 4 — Use in Dart

```dart
import 'package:locals/core/localization/l10n_extensions.dart';

Text(context.l10n.restaurantDirections)
```

### Step 5 — Hot restart

Press `R` in the Flutter terminal. Hot reload (`r`) may not load new ARB keys.

---

## Using strings in code

### Preferred: `context.l10n`

```dart
import 'package:locals/core/localization/l10n_extensions.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;

  return Column(
    children: [
      Text(l10n.settingsTitle),
      Text(l10n.settingsLanguage),
    ],
  );
}
```

### Alternative: `AppLocalizations.of(context)`

Equivalent to `context.l10n` when delegates are wired (they are, in `app.dart`).

### In controllers

Pass `AppLocalizations` or `BuildContext` from the view layer. Controllers should not import widget extensions unless they already receive `context` for navigation:

```dart
// In screen build method:
controller.sectionsFor(context.l10n, languageName);
```

---

## Placeholders and parameters

When a string contains dynamic values, define a **placeholder metadata** block next to the message.

### English

```json
"commonLevel": "Level {level}",
"@commonLevel": {
  "placeholders": {
    "level": {
      "type": "int"
    }
  }
},
"commonPointsShort": "+{points} pts",
"@commonPointsShort": {
  "placeholders": {
    "points": {
      "type": "int"
    }
  }
}
```

### Spanish (same structure, translated text)

```json
"commonLevel": "Nivel {level}",
"@commonLevel": {
  "placeholders": {
    "level": {
      "type": "int"
    }
  }
}
```

### Dart usage

```dart
context.l10n.commonLevel(user.level)
context.l10n.commonPointsShort(points)
```

Placeholder names in `{curly braces}` must match the `@key.placeholders` definition.

---

## Dynamic UI builders

Some screens build **lists or trees** from localized strings. Putting every label inline in the widget would be repetitive, so helpers live in `lib/core/localization/*_l10n.dart`.

### When to use a `*_l10n.dart` helper

| Scenario | Helper | Example |
|----------|--------|---------|
| Fixed list of pages with images + text | `OnboardL10n.buildPages(l10n)` | Onboarding carousel |
| Settings menu sections | `SettingsL10n.buildSections(l10n, languageName)` | Settings screen |
| Enum / id → display label | `FiltersL10n.categoryLabel(l10n, id)` | Map filter chips |
| Notification categories | `NotificationL10n` | Notification settings |
| Privacy toggles | `PrivacyL10n` | Privacy screen |

### Example: filter category id

Backend or model stores `id: 'restaurant'`. UI shows a translated label:

```dart
Text(FiltersL10n.categoryLabel(context.l10n, category.id))
```

### Example: onboarding pages

Onboarding builds `List<OnboardPageData>` from ARB strings. Initialization is deferred to **after the first frame** so `notifyListeners()` does not run during build:

```dart
// onboard_screen.dart — pattern to follow
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (!mounted) return;
  controller.initPages(OnboardL10n.buildPages(context.l10n));
});
```

### Creating a new helper

1. Add all string keys to both ARB files.
2. Create `lib/core/localization/my_feature_l10n.dart`.
3. Accept `AppLocalizations l10n` as a parameter (keeps helpers testable and free of `BuildContext`).
4. Call from the screen when building UI or in a post-frame callback if the controller notifies listeners.

---

## Runtime language switching

```
User taps Settings → Language
        │
        ▼
LanguagePickerSheet.show(context, currentLocale)
        │
        ▼
User selects locale → Navigator.pop(context, locale)
        │
        ▼
SettingsController → localeController.setLocale(selected)
        │
        ├── LocaleRepository.saveLanguageCode('es' | 'en')
        └── LocaleController.notifyListeners()
                │
                ▼
MyApp rebuilds (context.watch<LocaleController>)
        │
        ▼
MaterialApp.locale updates → all context.l10n strings refresh
```

### Files involved

| File | Role |
|------|------|
| `language_picker_sheet.dart` | Bottom sheet UI |
| `settings_controller.dart` | Handles tap, calls `setLocale` |
| `settings_screen.dart` | `context.watch<LocaleController>()` to rebuild sections |
| `locale_controller.dart` | Persists and broadcasts locale |
| `locale_repository.dart` | `SharedPreferences` key: `app_locale` |

### Rebuilding screens after locale change

Screens that cache localized lists must watch the locale controller or rebuild sections when locale changes:

```dart
@override
Widget build(BuildContext context) {
  context.watch<LocaleController>(); // force rebuild on language change
  final sections = SettingsL10n.buildSections(context.l10n, ...);
  // ...
}
```

---

## Locale resolution order

Defined in `lib/app/app.dart` → `localeResolutionCallback`:

1. **Saved user preference** — if `LocaleController.locale` is set (from Settings), use it.
2. **Device language** — if the OS language is `en` or `es`, use it.
3. **Fallback** — English (`AppLocales.en`).

On first launch with no saved preference, the app follows the device language when supported.

---

## API integration

### Client header

Use the same language as the UI when calling the backend:

```dart
import 'package:provider/provider.dart';
import 'package:locals/core/localization/locale_controller.dart';
import 'package:locals/core/localization/api_locale.dart';

final locale = context.read<LocaleController>().locale;
final acceptLanguage = ApiLocale.acceptLanguageHeader(locale);
// Returns "en" or "es"
```

Or from `LocaleController` directly:

```dart
localeController.acceptLanguageHeader; // "en" | "es"
```

### Server responsibility

| Data type | Who translates |
|-----------|----------------|
| Static UI | Flutter ARB files |
| Place names, descriptions, events | Backend using `Accept-Language` |
| User-generated content | Usually not translated; show as authored |

When implementing `*RepositoryImpl` HTTP calls, attach:

```
Accept-Language: en
```

or

```
Accept-Language: es
```

---

## Adding a new language

Example: add **French (`fr`)**.

### 1. Create ARB file

Copy `app_en.arb` → `app_fr.arb`, translate all values, set:

```json
"@@locale": "fr"
```

### 2. Register locale

`lib/core/localization/app_locales.dart`:

```dart
static const Locale fr = Locale('fr');
static const List<Locale> supported = [en, es, fr];

static const Map<String, String> displayNames = {
  'en': 'English',
  'es': 'Spanish',
  'fr': 'French',
};
```

Update `localizedDisplayName()` to return `l10n.languageFrench` (add that key to ARB files).

### 3. Add picker strings

In all ARB files:

```json
"languageFrench": "French"
```

(Spanish/French ARB would use the French word for “French” in that locale’s UI.)

### 4. Extend API locale helper

`api_locale.dart`:

```dart
if (locale?.languageCode == 'es') return 'es';
if (locale?.languageCode == 'fr') return 'fr';
return 'en';
```

### 5. Generate and test

```bash
flutter gen-l10n
flutter run
```

Verify every screen and `*_l10n.dart` helper; add missing translations if `gen-l10n` reports errors.

---

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `gen-l10n` fails | Key in `app_en.arb` missing from `app_es.arb` | Add matching key to all locale ARB files |
| New key not found in Dart | Generation not run | `flutter gen-l10n` then hot **restart** |
| Language does not change | Screen not rebuilding | `context.watch<LocaleController>()` or rebuild localized lists |
| `!_dirty` assertion on onboard | `notifyListeners()` during build | Defer init with `addPostFrameCallback` |
| Typo in generated getter | Wrong key name in ARB | Fix key in ARB and regenerate |
| Spanish shows English | Missing translation | Fill value in `app_es.arb` for that key |

### Verify generation manually

```bash
flutter gen-l10n
flutter analyze lib
```

---

## Checklist

When adding localized UI:

- [ ] Key added to `lib/l10n/app_en.arb`
- [ ] Same key added to `lib/l10n/app_es.arb` with translation
- [ ] Placeholder `@metadata` copied to all locales if used
- [ ] `flutter gen-l10n` run (or app rebuilt)
- [ ] Widget uses `context.l10n.myKey` (not a hardcoded string)
- [ ] Hot restart performed
- [ ] Tested in **English** and **Spanish** from Settings → Language
- [ ] If list/section UI: updated or created `*_l10n.dart` helper if needed
- [ ] Future API call includes `Accept-Language` when dynamic content should localize

---

## Quick reference

```bash
# Install deps
flutter pub get

# Regenerate strings
flutter gen-l10n

# Run app
flutter run

# After ARB edits: hot restart (R), not just hot reload (r)
```

```dart
// Read a string
import 'package:locals/core/localization/l10n_extensions.dart';
Text(context.l10n.commonCancel)

// With placeholder
Text(context.l10n.commonLevel(12))

// Change language programmatically
await context.read<LocaleController>().setLocale(AppLocales.es);
```
