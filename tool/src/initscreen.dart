import 'dart:io';
import 'utils.dart';

Future<void> makeInitialScreenRaw(String input, [String? className]) async {
  // If input looks like a dart file path, prefer that. Otherwise, search by name.
  final isPath = (input.contains('/') || input.contains('\\')) && input.endsWith('.dart');
  String? libFilePath;
  String screenClass;
  if (isPath) {
    var p = input.replaceAll('\\', '/');
    if (!p.startsWith('lib/')) {
      p = 'lib/$p';
    }
    final f = File(p);
    if (!f.existsSync()) {
      stdout.writeln('Screen file not found: $p');
      return;
    }
    libFilePath = p;
    if (className != null && className.trim().isNotEmpty) {
      screenClass = className.trim();
    } else {
      final base = p.split('/').last; // e.g., home_screen.dart
      final nameNoExt = base.substring(0, base.length - 5); // remove .dart
      final parts = nameNoExt.split('_').map((w) => w.isEmpty ? w : (w[0].toUpperCase() + w.substring(1))).join();
      screenClass = parts;
      if (!screenClass.endsWith('Screen')) {
        screenClass = '${screenClass}Screen';
      }
    }
  } else {
    final snake = toSnakeCase(input);
    final pascal = toPascalCase(input);
    // Preferred default path first
    final defaultPath = joinPath(['lib', 'features', snake, 'view', '${snake}_screen.dart']).replaceAll('\\', '/');
    if (File(defaultPath).existsSync()) {
      libFilePath = defaultPath;
      screenClass = className != null && className.trim().isNotEmpty ? className.trim() : '${pascal}Screen';
    } else {
      // Search whole lib/ for a matching file or class
      libFilePath = await _findScreenFileByName(snake, pascal);
      if (libFilePath == null) {
        stdout.writeln('Could not locate screen for "$input". Create it first or pass a file path to the command.');
        return;
      }
      screenClass = className != null && className.trim().isNotEmpty ? className.trim() : '${pascal}Screen';
    }
  }
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final routerFile = File(routerPath);
  if (!routerFile.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  final importRelPath = _relativeImportFromApp(libFilePath);
  var content = await routerFile.readAsString();
  final importLine = "import '$importRelPath';";
  if (!content.contains(importLine)) {
    final lines = content.split('\n');
    var lastImportIndex = -1;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].trim().startsWith('import ')) {
        lastImportIndex = i;
      }
    }
    if (lastImportIndex != -1) {
      lines.insert(lastImportIndex + 1, importLine);
      content = lines.join('\n');
      stdout.writeln('Added import for $screenClass from $importRelPath');
    }
  } else {
    stdout.writeln('Import exists for $screenClass');
  }
  // Remove any existing '/' route to avoid duplicates.
  final rootRouteRegex = RegExp(r"[\s]*GoRoute\(\s*path:\s*'/'\s*,[\s\S]*?        \),");
  if (rootRouteRegex.hasMatch(content)) {
    content = content.replaceAll(rootRouteRegex, '');
    stdout.writeln("Removed existing '/' route");
  }
  // Insert new '/' route
  String routeBlock = """

        GoRoute(
          path: '/',
          builder: (context, state) => const ${screenClass}(),
        ),""";
  final profileMarker = "path: '/profile'";
  final profileIndex = content.indexOf(profileMarker);
  if (profileIndex != -1) {
    final closeIndex = content.indexOf('        ),', profileIndex);
    if (closeIndex != -1) {
      final insertPos = closeIndex + '        ),'.length;
      content = content.substring(0, insertPos) + routeBlock + content.substring(insertPos);
      stdout.writeln("Inserted '/' route under ShellRoute");
    } else {
      final routesCloseIndex = content.indexOf('      ],');
      if (routesCloseIndex != -1) {
        content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
        stdout.writeln("Appended '/' route under ShellRoute");
      }
    }
  } else {
    final routesCloseIndex = content.indexOf('      ],');
    if (routesCloseIndex != -1) {
      content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
      stdout.writeln("Appended '/' route under ShellRoute");
    } else {
      stdout.writeln('Could not locate ShellRoute routes list');
    }
  }
  await routerFile.writeAsString(content);
  stdout.writeln("Initial route '/' now points to $screenClass");
}

Future<void> makeInitialScreen(String snake, String pascal) async {
  var featureSnake = snake;
  var screenPascal = pascal;
  final featureDir = Directory(joinPath(['lib', 'features', featureSnake]));
  if (!featureDir.existsSync() && snake.endsWith('s')) {
    final singular = snake.substring(0, snake.length - 1);
    final singularDir = Directory(joinPath(['lib', 'features', singular]));
    if (singularDir.existsSync()) {
      featureSnake = singular;
      screenPascal = toPascalCase(singular);
      stdout.writeln('Using singular feature: $featureSnake');
    }
  }
  final screenPath = joinPath(['lib', 'features', featureSnake, 'view', '${featureSnake}_screen.dart']);
  if (!File(screenPath).existsSync()) {
    stdout.writeln('Screen file not found: $screenPath');
    stdout.writeln('Create the screen first: showravkit create screen $screenPascal');
    return;
  }
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final routerFile = File(routerPath);
  if (!routerFile.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  var content = await routerFile.readAsString();
  final importLine = "import '../features/$featureSnake/view/${featureSnake}_screen.dart';";
  if (!content.contains(importLine)) {
    final lines = content.split('\n');
    var lastImportIndex = -1;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].trim().startsWith('import ')) {
        lastImportIndex = i;
      }
    }
    if (lastImportIndex != -1) {
      lines.insert(lastImportIndex + 1, importLine);
      content = lines.join('\n');
      stdout.writeln('Added import for ${screenPascal}Screen');
    }
  } else {
    stdout.writeln('Import exists for ${screenPascal}Screen');
  }
  // Remove any existing '/' route to avoid duplicates.
  final rootRouteRegex = RegExp(r"[\s]*GoRoute\(\s*path:\s*'/'\s*,[\s\S]*?        \),");
  if (rootRouteRegex.hasMatch(content)) {
    content = content.replaceAll(rootRouteRegex, '');
    stdout.writeln("Removed existing '/' route");
  }
  // Insert new '/' route under ShellRoute, near '/profile' if possible.
  final profileMarker = "path: '/profile'";
  final profileIndex = content.indexOf(profileMarker);
  String routeBlock = """

        GoRoute(
          path: '/',
          builder: (context, state) => const ${screenPascal}Screen(),
        ),""";
  if (profileIndex != -1) {
    final closeIndex = content.indexOf('        ),', profileIndex);
    if (closeIndex != -1) {
      final insertPos = closeIndex + '        ),'.length;
      content = content.substring(0, insertPos) + routeBlock + content.substring(insertPos);
      stdout.writeln("Inserted '/' route under ShellRoute");
    } else {
      final routesCloseIndex = content.indexOf('      ],');
      if (routesCloseIndex != -1) {
        content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
        stdout.writeln("Appended '/' route under ShellRoute");
      }
    }
  } else {
    final routesCloseIndex = content.indexOf('      ],');
    if (routesCloseIndex != -1) {
      content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
      stdout.writeln("Appended '/' route under ShellRoute");
    } else {
      stdout.writeln('Could not locate ShellRoute routes list');
    }
  }
  await routerFile.writeAsString(content);
  stdout.writeln("Initial route '/' now points to ${screenPascal}Screen");
}

Future<void> removeInitialScreen(String snake, String pascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final routerFile = File(routerPath);
  if (!routerFile.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  var content = await routerFile.readAsString();
  final rootRouteRegex = RegExp(r"[\s]*GoRoute\(\s*path:\s*'/'\s*,[\s\S]*?        \),");
  if (rootRouteRegex.hasMatch(content)) {
    content = content.replaceAll(rootRouteRegex, '');
    stdout.writeln("Removed '/' initial route");
  } else {
    stdout.writeln("No '/' route found to remove");
  }
  // Ensure app still has a valid initial route: redirect '/' to '/profile' if not present
  if (!content.contains("path: '/'")) {
    final profileMarker = "path: '/profile'";
    final profileIndex = content.indexOf(profileMarker);
    String redirectBlock = """

        GoRoute(
          path: '/',
          redirect: (context, state) => '/profile',
        ),""";
    if (profileIndex != -1) {
      final closeIndex = content.indexOf('        ),', profileIndex);
      if (closeIndex != -1) {
        final insertPos = closeIndex + '        ),'.length;
        content = content.substring(0, insertPos) + redirectBlock + content.substring(insertPos);
        stdout.writeln("Inserted '/' redirect to /profile");
      } else {
        final routesCloseIndex = content.indexOf('      ],');
        if (routesCloseIndex != -1) {
          content = content.substring(0, routesCloseIndex) + redirectBlock + content.substring(routesCloseIndex);
          stdout.writeln("Appended '/' redirect to /profile under ShellRoute");
        }
      }
    } else {
      final routesCloseIndex = content.indexOf('      ],');
      if (routesCloseIndex != -1) {
        content = content.substring(0, routesCloseIndex) + redirectBlock + content.substring(routesCloseIndex);
        stdout.writeln("Appended '/' redirect to /profile under ShellRoute");
      } else {
        stdout.writeln('Could not locate ShellRoute routes list to insert redirect');
      }
    }
  }
  await routerFile.writeAsString(content);
  stdout.writeln("Initial route '/' removal completed");
}

Future<String?> _findScreenFileByName(String snake, String pascal) async {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) return null;
  final targetFileName = '${snake}_screen.dart';
  String? found;
  await for (final entity in libDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final p = entity.path.replaceAll('\\', '/');
      final base = p.split('/').last;
      if (base == targetFileName) {
        found = p;
        break;
      }
    }
  }
  if (found != null) return found;
  // Fallback: search file contents for class ${pascal}Screen
  await for (final entity in libDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      try {
        final txt = await entity.readAsString();
        if (txt.contains('class ${pascal}Screen')) {
          return entity.path.replaceAll('\\', '/');
        }
      } catch (_) {}
    }
  }
  return null;
}

String _relativeImportFromApp(String libFilePath) {
  // Router is lib/app/router.dart; make path relative to lib/app/
  if (!libFilePath.startsWith('lib/')) {
    return libFilePath;
  }
  final afterLib = libFilePath.substring('lib/'.length);
  return '../$afterLib';
}
