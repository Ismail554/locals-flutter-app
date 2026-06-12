# ShowravKit CLI — Project Scaffolding and Utilities

Run these commands from the project root:

```bash
dart run tool/showravkit.dart <command> ...
```

This tool helps you scaffold features, manage role‑based screens, toggle UI helpers (shimmer/bottom bar), set/remove the initial route, and bootstrap a base architecture.

## Quick Start

- Create a simple feature screen:
  ```bash
  dart run tool/showravkit.dart create screen Home
  ```
  Generates files under:
  - lib/features/home/controller/home_controller.dart
  - lib/features/home/model/home_model.dart
  - lib/features/home/repository/home_repository.dart
  - lib/features/home/view/home_screen.dart
  - lib/features/home/view/widgets/home_widgets.dart

- Create a role‑based screen (two forms):
  ```bash
  dart run tool/showravkit.dart create screen Admin Profile
  # or
  dart run tool/showravkit.dart create screen Profile in Admin
  ```
  Generates a nested structure:
  - lib/features/admin/profile/controller/profile_controller.dart
  - lib/features/admin/profile/model/profile_model.dart
  - lib/features/admin/profile/repository/profile_repository.dart
  - lib/features/admin/profile/view/profile_screen.dart
  - lib/features/admin/profile/view/widgets/profile_widgets.dart

  Notes:
  - The role directory (e.g., admin) is created automatically if missing.
  - The screen lives inside lib/features/<role>/<screen>.

## Command Reference

### Create

- Create a screen in a feature:
  ```bash
  dart run tool/showravkit.dart create screen <Name>
  ```

- Create a screen inside a role (two styles):
  ```bash
  dart run tool/showravkit.dart create screen <RoleName> <ScreenName>
  dart run tool/showravkit.dart create screen <ScreenName> in <RoleName>
  ```
  - RoleName examples: admin, teacher, student, member
  - Auto‑creates the role directory if it doesn’t exist

- Create only a repository in a feature:
  ```bash
  dart run tool/showravkit.dart create repository <Name>
  ```

- Create a standalone widgets file in a feature:
  ```bash
  dart run tool/showravkit.dart create widget <Name>
  ```

- Create base architecture:
  ```bash
  dart run tool/showravkit.dart create arc Base
  ```
  Creates/updates:
  - lib/core/core.dart
  - lib/core/startup/startup.dart (bootstraps MyApp)
  - lib/app/app.dart, lib/app/app_scaffold.dart, lib/app/router.dart
  - lib/shared/components/bottom_nav_bar.dart
  - lib/main.dart (wires startFlutterApp)
  - assets/ directory and adds to pubspec.yaml (under flutter -> assets)
  - Ensures dependencies: provider, go_router, flutter_screenutil (runs `flutter pub get` if possible)

### Remove

- Remove an entire feature (dangerous; prompts for confirmation):
  ```bash
  dart run tool/showravkit.dart remove screen <Name>
  ```
  Also cleans router imports/routes, bottom nav destinations, and scaffold helpers.

- Remove a single screen under a role (prompts for confirmation):
  ```bash
  dart run tool/showravkit.dart remove screen <RoleName> <ScreenName>
  dart run tool/showravkit.dart remove screen <ScreenName> in <RoleName>
  ```
  Deletes only lib/features/<role>/<screen> and cleans references where applicable.

### Bottom Bar

- Show bottom bar for a screen:
  ```bash
  dart run tool/showravkit.dart show bottombar <Name>
  ```

- Remove bottom bar for a screen:
  ```bash
  dart run tool/showravkit.dart remove bottombar <Name>
  ```

### Shimmer

- Add shimmer UI support to a screen:
  ```bash
  dart run tool/showravkit.dart makeshimmer screen <Name>
  ```

- Remove shimmer UI support from a screen:
  ```bash
  dart run tool/showravkit.dart removeshimmer screen <Name>
  ```

### Initial Screen

Set or remove the app’s `'/'` initial route in lib/app/router.dart.

- Set initial route (flexible input):
  ```bash
  dart run tool/showravkit.dart mkinitscreen <NameOrPath> [ClassName]
  ```
  - When you pass a file path (e.g., `lib/screens/home/home_screen.dart`), the tool imports that file and tries to infer the widget class name from the filename. You can override with `[ClassName]`.
  - When you pass a name (e.g., `Home`), the tool searches under `lib/` for:
    1) lib/features/<name>/view/<name>_screen.dart
    2) Any lib/**/<name>_screen.dart
    3) Any file that defines `class <PascalName>Screen`
  - Idempotent: avoids duplicate imports and replaces any existing `'/'` route.

- Remove initial route:
  ```bash
  dart run tool/showravkit.dart rminitscreen
  ```
  - Removes the `'/'` route and inserts a safe redirect to `'/profile'` to keep the app bootable.

## Conventions

- Name processing:
  - Inputs are normalized to `snake_case` for paths and `PascalCase` for class names.
  - Example: “Admin Profile” → role `admin`, screen `profile`, class `ProfileScreen`.

- Output structure:
  - Feature: lib/features/<feature>/...
  - Role screen: lib/features/<role>/<screen>/...

- Idempotent writes:
  - Files are only written if missing; existing files are never overwritten by scaffolding.

- Safety on removal:
  - Deletions prompt for confirmation (`Y/Yes`) and clean related references where possible.

## Examples

```bash
# Simple feature
dart run tool/showravkit.dart create screen Home

# Role-based screens (two styles)
dart run tool/showravkit.dart create screen Admin Profile
dart run tool/showravkit.dart create screen Profile in Admin

# Remove a role-based screen (two styles)
dart run tool/showravkit.dart remove screen Admin Profile
dart run tool/showravkit.dart remove screen Profile in Admin

# Toggle bottom bar
dart run tool/showravkit.dart show bottombar Home
dart run tool/showravkit.dart remove bottombar Home

# Shimmer for a screen
dart run tool/showravkit.dart makeshimmer screen Profile
dart run tool/showravkit.dart removeshimmer screen Profile

# Initial screen
dart run tool/showravkit.dart mkinitscreen Home
dart run tool/showravkit.dart mkinitscreen lib/screens/home/home_screen.dart
dart run tool/showravkit.dart rminitscreen

# Bootstrap base architecture
dart run tool/showravkit.dart create arc Base
```

## Notes & Limitations

- Creating a screen does not auto‑register a route in lib/app/router.dart. Use `mkinitscreen` to set `'/'`, or add additional routes manually.
- Role names and screen names can contain spaces or camel case; the tool converts them appropriately.
- If `flutter pub get` fails during `create arc Base`, dependencies are still written; run `flutter pub get` manually.

---

Source files:
- tool/showravkit.dart
- tool/src/create.dart
- tool/src/remove.dart
- tool/src/initscreen.dart
- tool/src/navigation.dart
- tool/src/utils.dart
