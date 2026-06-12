import 'dart:io';
import 'utils.dart';

Future<void> showBottomBarForScreen(String snake, String pascal) async {
  // Enable BottomNavBar in the app scaffold (idempotent)
  final scaffoldPath = joinPath(['lib', 'app', 'app_scaffold.dart']);
  final scaffoldFile = File(scaffoldPath);
  if (!scaffoldFile.existsSync()) {
    stdout.writeln('App scaffold not found: $scaffoldPath');
    return;
  }
  var scaffold = await scaffoldFile.readAsString();
  final bnImport = "import '../shared/components/bottom_nav_bar.dart';";
  if (!scaffold.contains(bnImport)) {
    final lines = scaffold.split('\n');
    var lastImportIndex = -1;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].trim().startsWith('import ')) {
        lastImportIndex = i;
      }
    }
    if (lastImportIndex != -1) {
      lines.insert(lastImportIndex + 1, bnImport);
      scaffold = lines.join('\n');
      stdout.writeln('Inserted BottomNavBar import into app_scaffold.dart');
    }
  }
  if (!scaffold.contains('bottomNavigationBar: BottomNavBar(')) {
    final marker = 'body: child,';
    final idx = scaffold.indexOf(marker);
    if (idx != -1) {
      final insertPos = idx + marker.length;
      final block = """
\n      bottomNavigationBar: BottomNavBar(
        selectedIndex: index,
        onSelected: (i) => _onTap(context, i),
      ),""";
      scaffold = scaffold.substring(0, insertPos) + block + scaffold.substring(insertPos);
      stdout.writeln('Enabled BottomNavBar in app_scaffold.dart');
    }
  }
  await scaffoldFile.writeAsString(scaffold);
  stdout.writeln('Bottom bar enabled.');
}

Future<void> removeBottomBarForScreen(String snake, String pascal) async {
  await _cleanupScaffoldForScreen('');
  stdout.writeln('Bottom bar disabled.');
}

Future<void> _cleanupRouterForScreen(String snake, String pascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) return;
  var content = await file.readAsString();
  final candidates = <String>[snake, '${snake}s'];
  for (final c in candidates) {
    final importLine = "import '../features/$c/view/${c}_screen.dart';";
    if (content.contains(importLine)) {
      content = content.replaceAll(importLine, '');
      stdout.writeln('Removed import for ${toPascalCase(c)}Screen');
    }
    final routeRegex = RegExp(r"^\s*GoRoute\(\s*path:\s*'/" + RegExp.escape(c) + r"'\s*,[\s\S]*?^\s*\),\s*$", multiLine: true);
    content = content.replaceAll(routeRegex, '');
  }
  content = _normalizeRouterContent(content);
  await file.writeAsString(content);
  stdout.writeln('Router cleaned for $snake');
}

Future<void> _cleanupBottomNavForScreen(String pascal) async {
  final navPath = joinPath(['lib', 'shared', 'components', 'bottom_nav_bar.dart']);
  final navFile = File(navPath);
  if (!navFile.existsSync()) return;
  var nav = await navFile.readAsString();
  final labels = <String>[pascal, '${pascal}s'];
  for (final l in labels) {
    final destRegex = RegExp(r"[\s]*NavigationDestination\([\s\S]*?label:\s*'" + RegExp.escape(l) + r"'\s*,[\s\S]*?\),");
    if (destRegex.hasMatch(nav)) {
      nav = nav.replaceAll(destRegex, '');
      stdout.writeln('Removed bottom nav destination: $l');
    }
  }
  await navFile.writeAsString(nav);
}

Future<void> _cleanupScaffoldForScreen(String snake) async {
  final scaffoldPath = joinPath(['lib', 'app', 'app_scaffold.dart']);
  final scaffoldFile = File(scaffoldPath);
  if (!scaffoldFile.existsSync()) return;
  var s = await scaffoldFile.readAsString();
  final start = s.indexOf('bottomNavigationBar: BottomNavBar(');
  if (start != -1) {
    final end = s.indexOf('),', start);
    if (end != -1) {
      s = s.substring(0, start) + s.substring(end + 2);
      stdout.writeln('Removed BottomNavBar block from app_scaffold.dart');
    }
  }
  final bnImport = "import '../shared/components/bottom_nav_bar.dart';";
  s = s.replaceAll(bnImport, '');
  await scaffoldFile.writeAsString(s);
  stdout.writeln('Scaffold cleaned');
}

String _normalizeRouterContent(String content) {
  content = content.replaceAllMapped(
    RegExp(r"(\n\s*\),\s*\n)\s*\),\s*\n"),
    (m) => m.group(1)!,
  );
  content = content.replaceAll('        ),      ],', '        ),\n      ],');
  return content;
}

Future<void> addRouteForFeature(String snake, String pascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  var content = await file.readAsString();
  final importLine = "import '../features/$snake/view/${snake}_screen.dart';";
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
      stdout.writeln('Added import for ${pascal}Screen');
    }
  } else {
    stdout.writeln('Import exists for ${pascal}Screen');
  }
  final routeMarker = "path: '/$snake'";
  if (content.contains(routeMarker)) {
    stdout.writeln('Route already exists: /$snake');
  } else {
    final routesCloseIndex = content.indexOf('      ],');
    final routeBlock = """

        GoRoute(
          path: '/$snake',
          builder: (context, state) => const ${pascal}Screen(),
        ),""";
    if (routesCloseIndex != -1) {
      content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
      stdout.writeln('Added route /$snake under ShellRoute');
    } else {
      stdout.writeln('Could not locate ShellRoute routes list');
    }
  }
  content = _normalizeRouterContent(content);
  await file.writeAsString(content);
}

Future<void> addRouteForPath(List<String> dirSegmentsSnake, String screenSnake, String screenPascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  var content = await file.readAsString();
  final rel = dirSegmentsSnake.join('/');
  final importLine = "import '../features/$rel/$screenSnake/view/${screenSnake}_screen.dart';";
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
  final routeMarker = "path: '/$screenSnake'";
  if (content.contains(routeMarker)) {
    stdout.writeln('Route already exists: /$screenSnake');
  } else {
    final routesCloseIndex = content.indexOf('      ],');
    final routeBlock = """

        GoRoute(
          path: '/$screenSnake',
          builder: (context, state) => const ${screenPascal}Screen(),
        ),""";
    if (routesCloseIndex != -1) {
      content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
      stdout.writeln('Added route /$screenSnake under ShellRoute');
    } else {
      stdout.writeln('Could not locate ShellRoute routes list');
    }
  }
  content = _normalizeRouterContent(content);
  await file.writeAsString(content);
}

Future<void> addRouteForRole(String roleSnake, String screenSnake, String screenPascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  var content = await file.readAsString();
  final importLine = "import '../features/$roleSnake/$screenSnake/view/${screenSnake}_screen.dart';";
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
  final routeMarker = "path: '/$screenSnake'";
  if (content.contains(routeMarker)) {
    stdout.writeln('Route already exists: /$screenSnake');
  } else {
    final routesCloseIndex = content.indexOf('      ],');
    final routeBlock = """

        GoRoute(
          path: '/$screenSnake',
          builder: (context, state) => const ${screenPascal}Screen(),
        ),""";
    if (routesCloseIndex != -1) {
      content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
      stdout.writeln('Added route /$screenSnake under ShellRoute');
    } else {
      stdout.writeln('Could not locate ShellRoute routes list');
    }
  }
  content = _normalizeRouterContent(content);
  await file.writeAsString(content);
}
