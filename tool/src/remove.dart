import 'dart:io';
import 'utils.dart';

Future<void> removeScreen(String snake, String pascal, {bool force = false}) async {
  final featureDir = joinPath(['lib', 'features', snake]);
  final dir = Directory(featureDir);
  final pluralDir = Directory(joinPath(['lib', 'features', '${snake}s']));
  Directory? existsDir;
  if (dir.existsSync()) {
    existsDir = dir;
  } else if (pluralDir.existsSync()) {
    existsDir = pluralDir;
    stdout.writeln('Using plural feature: ${snake}s');
  }
  if (existsDir == null) {
    stdout.writeln('Feature not found: $featureDir');
    await cleanupRouterForScreen(snake, pascal);
    await cleanupBottomNavForScreen(pascal);
    await cleanupScaffoldForScreen(snake);
    return;
  }
  if (!force) {
    final items = await existsDir.list(recursive: true).toList();
    stdout.writeln('About to delete ${items.length} items under ${existsDir.path}');
    stdout.write('Type Y to confirm (or use -y/--yes to skip): ');
    final input = stdin.readLineSync();
    final ok = input != null && (input.toLowerCase() == 'y' || input.toLowerCase() == 'yes');
    if (!ok) {
      stdout.writeln('Aborted');
      return;
    }
  }
  await existsDir.delete(recursive: true);
  stdout.writeln('Deleted feature: ${existsDir.path}');
  await cleanupRouterForScreen(snake, pascal);
  await cleanupBottomNavForScreen(pascal);
  await cleanupScaffoldForScreen(snake);
}

Future<void> removeScreenInDir(String dirSnake, String screenSnake, String screenPascal, {bool force = false}) async {
  final roleDir = joinPath(['lib', 'features', dirSnake]);
  final baseDir = joinPath([roleDir, screenSnake]);
  if (!Directory(roleDir).existsSync()) {
    stdout.writeln('Role dir not found: $roleDir');
    await cleanupRouterForScreenInDir(dirSnake, screenSnake, screenPascal);
    await cleanupBottomNavForScreen(screenPascal);
    await cleanupScaffoldForScreen(screenSnake);
    return;
  }
  if (!Directory(baseDir).existsSync()) {
    stdout.writeln('Screen dir not found: $baseDir');
    await cleanupRouterForScreenInDir(dirSnake, screenSnake, screenPascal);
    await cleanupBottomNavForScreen(screenPascal);
    await cleanupScaffoldForScreen(screenSnake);
    return;
  }
  if (!force) {
    final items = await Directory(baseDir).list(recursive: true).toList();
    stdout.writeln('About to delete ${items.length} items under $baseDir');
    stdout.write('Type Y to confirm (or use -y/--yes to skip): ');
    final input = stdin.readLineSync();
    final ok = input != null && (input.toLowerCase() == 'y' || input.toLowerCase() == 'yes');
    if (!ok) {
      stdout.writeln('Aborted');
      return;
    }
  }
  await Directory(baseDir).delete(recursive: true);
  stdout.writeln('Deleted screen dir: $baseDir');
  await cleanupRouterForScreenInDir(dirSnake, screenSnake, screenPascal);
  await cleanupBottomNavForScreen(screenPascal);
  await cleanupScaffoldForScreen(screenSnake);
}

Future<void> cleanupRouterForScreen(String snake, String pascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) return;
  var content = await file.readAsString();
  final candidates = <String>[snake, '${snake}s'];
  for (final c in candidates) {
    final importLine = "import '../features/$c/view/${c}_screen.dart';";
    if (content.contains(importLine)) {
      content = content.replaceAll(importLine, '');
      stdout.writeln('Removed import for ${pascal}Screen');
    }
    final routeRegex = RegExp(r"^\s*GoRoute\(\s*path:\s*'/" + RegExp.escape(c) + r"'\s*,[\s\S]*?^\s*\),\s*$", multiLine: true);
    content = content.replaceAll(routeRegex, '');
  }
  // Normalize duplicates and compact artifacts
  content = _normalizeRouterContent(content);
  await file.writeAsString(content);
  stdout.writeln('Router cleaned for $snake');
}

Future<void> cleanupRouterForScreenInDir(String dirSnake, String screenSnake, String pascal) async {
  final routerPath = joinPath(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) return;
  var content = await file.readAsString();
  final importLine = "import '../features/$dirSnake/$screenSnake/view/${screenSnake}_screen.dart';";
  if (content.contains(importLine)) {
    content = content.replaceAll(importLine, '');
    stdout.writeln('Removed import for ${pascal}Screen');
  }
  final routeRegex = RegExp(r"^\s*GoRoute\(\s*path:\s*'/" + RegExp.escape(screenSnake) + r"'\s*,[\s\S]*?^\s*\),\s*$", multiLine: true);
  content = content.replaceAll(routeRegex, '');
  // Normalize duplicates and compact artifacts
  content = _normalizeRouterContent(content);
  await file.writeAsString(content);
  stdout.writeln('Router cleaned for $dirSnake/$screenSnake');
}

Future<void> cleanupBottomNavForScreen(String pascal) async {
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

Future<void> cleanupScaffoldForScreen(String snake) async {
  final scaffoldPath = joinPath(['lib', 'app', 'app_scaffold.dart']);
  final scaffoldFile = File(scaffoldPath);
  if (!scaffoldFile.existsSync()) return;
  var s = await scaffoldFile.readAsString();
  s = s.replaceAll("if (location.startsWith('/$snake')) return 2;", '');
  s = s.replaceAll("context.go('/$snake');", '');
  s = s.replaceAll("context.go('/${snake}s');", '');
  await scaffoldFile.writeAsString(s);
  stdout.writeln('Scaffold cleaned for $snake');
}

String _normalizeRouterContent(String content) {
  // Remove duplicate closing lines "        )," occurring back-to-back
  content = content.replaceAllMapped(
    RegExp(r"(\n\s*\),\s*\n)\s*\),\s*\n"),
    (m) => m.group(1)!,
  );
  // Ensure routes close bracket is on its own line
  content = content.replaceAll('        ),      ],', '        ),\n      ],');
  return content;
}
