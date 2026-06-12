import 'dart:io';
import 'src/utils.dart' as u;
import 'src/create.dart' as gen;
import 'src/remove.dart' as rem;
import 'src/navigation.dart' as nav;
import 'src/shimmer.dart' as shm;
import 'src/initscreen.dart' as init;

// Allowed commands (run from project root):
// - dart run tool/showravkit.dart create screen <Name>
// - dart run tool/showravkit.dart create screen <RoleName> <ScreenName>
// - dart run tool/showravkit.dart create screen <ScreenName> in <RoleName>
// - dart run tool/showravkit.dart create screen <ScreenName> in <PathExpr>
// Example path expressions for multi-dir screen creation:
// - dart run tool/showravkit.dart create screen user_home in features->user->home
// - dart run tool/showravkit.dart create screen user_home in features/user/home
// - dart run tool/showravkit.dart create screen user_home in lib/features/user/home
// - dart run tool/showravkit.dart create repository <Name>
// - dart run tool/showravkit.dart create widget <Name>
// - dart run tool/showravkit.dart create arc Base
//   (Sets up core/startup/startup.dart, updates lib/main.dart, creates assets/)
// - dart run tool/showravkit.dart remove screen <Name>
// - dart run tool/showravkit.dart remove screen <RoleName> <ScreenName>
// - dart run tool/showravkit.dart remove screen <ScreenName> in <RoleName>
// - dart run tool/showravkit.dart show bottombar [Name]
// - dart run tool/showravkit.dart remove bottombar [Name]
// - dart run tool/showravkit.dart makeshimmer screen <Name>
// - dart run tool/showravkit.dart removeshimmer screen <Name>
// - dart run tool/showravkit.dart mkinitscreen <NameOrPath> [ClassName]
// - dart run tool/showravkit.dart rminitscreen

// Tips:
// - Add -y or --yes at the end of remove commands to skip confirmation

void main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    exit(64);
  }
  final command = args[0].toLowerCase();
  // Validate args per command to allow optional parameters for bottombar commands
  // create command: showravkit create <type> <Name>
  if (command == 'create') {
    final type = args[1].toLowerCase();
    final pkg = u.readPackageName();
    if (type == 'screen') {
      if (args.length >= 5 && args[3].toLowerCase() == 'in') {
        final screenRaw = args[2];
        final pathExpr = args.sublist(4).join(' ');
        final segs = u.parseDirSegments(pathExpr);
        final screenSnake = u.toSnakeCase(screenRaw);
        final screenPascal = u.toPascalCase(screenRaw);
        await gen.createScreenInPath(pkg, segs, screenSnake, screenPascal);
        await gen.ensureDependencies(alwaysPubGet: true);
        await nav.addRouteForPath(segs, screenSnake, screenPascal);
      } else if (args.length >= 4) {
        final dirRaw = args[2];
        final screenRaw = args[3];
        final dirSnake = u.toSnakeCase(dirRaw);
        final screenSnake = u.toSnakeCase(screenRaw);
        final screenPascal = u.toPascalCase(screenRaw);
        await gen.createScreenInDir(pkg, dirSnake, screenSnake, screenPascal);
        await gen.ensureDependencies(alwaysPubGet: true);
        await nav.addRouteForRole(dirSnake, screenSnake, screenPascal);
      } else {
        final name = args[2];
        final snake = u.toSnakeCase(name);
        final pascal = u.toPascalCase(name);
        await gen.createScreen(pkg, snake, pascal);
        await gen.ensureDependencies(alwaysPubGet: true);
        await nav.addRouteForFeature(snake, pascal);
      }
    } else if (type == 'repository') {
      final name = args[2];
      final snake = u.toSnakeCase(name);
      final pascal = u.toPascalCase(name);
      await gen.createRepository(pkg, snake, pascal);
    } else if (type == 'widget') {
      final name = args[2];
      final snake = u.toSnakeCase(name);
      final pascal = u.toPascalCase(name);
      await gen.createWidgets(pkg, snake, pascal);
      await gen.ensureDependencies(alwaysPubGet: true);
    } else if (type == 'arc') {
      await gen.createArc();
    } else {
      _printUsage();
      exit(64);
    }
  // remove command: showravkit remove screen <Name>
  } else if (command == 'remove') {
    final type = args[1].toLowerCase();
    if (type == 'screen') {
      // Support optional -y/--yes flag to skip confirmation
      final forceYes = args.any((a) => a == '-y' || a == '--yes');
      // Collect positional args after 'remove screen', excluding flags
      final pos = <String>[];
      for (var i = 2; i < args.length; i++) {
        final a = args[i];
        if (a == '-y' || a == '--yes') continue;
        pos.add(a);
      }
      if (pos.length >= 3 && pos[1].toLowerCase() == 'in') {
        final screenRaw = pos[0];
        final dirRaw = pos[2];
        final dirSnake = u.toSnakeCase(dirRaw);
        final screenSnake = u.toSnakeCase(screenRaw);
        final screenPascal = u.toPascalCase(screenRaw);
        await rem.removeScreenInDir(dirSnake, screenSnake, screenPascal, force: forceYes);
      } else if (pos.length >= 2) {
        // Treat as "<RoleName> <ScreenName>"
        final dirRaw = pos[0];
        final screenRaw = pos[1];
        final dirSnake = u.toSnakeCase(dirRaw);
        final screenSnake = u.toSnakeCase(screenRaw);
        final screenPascal = u.toPascalCase(screenRaw);
        await rem.removeScreenInDir(dirSnake, screenSnake, screenPascal, force: forceYes);
      } else if (pos.length == 1) {
        final name = pos[0];
        final snake = u.toSnakeCase(name);
        final pascal = u.toPascalCase(name);
        await rem.removeScreen(snake, pascal, force: forceYes);
      } else {
        _printUsage();
        exit(64);
      }
    } else if (type == 'bottombar') {
      // Optional name; removal now disables the bottom bar globally
      if (args.length >= 3) {
        final name = args[2];
        final snake = u.toSnakeCase(name);
        final pascal = u.toPascalCase(name);
        await nav.removeBottomBarForScreen(snake, pascal);
      } else {
        await nav.removeBottomBarForScreen('home', 'Home');
      }
    } else {
      _printUsage();
      exit(64);
    }
  // show command: showravkit show bottombar <Name>
  } else if (command == 'show') {
    final type = args[1].toLowerCase();
    if (type == 'bottombar') {
      if (args.length >= 3) {
        final name = args[2];
        final snake = u.toSnakeCase(name);
        final pascal = u.toPascalCase(name);
        await nav.showBottomBarForScreen(snake, pascal);
      } else {
        await nav.showBottomBarForScreen('home', 'Home');
      }
    } else {
      _printUsage();
      exit(64);
    }
  // makeshimmer command: showravkit makeshimmer screen <Name>
  } else if (command == 'makeshimmer') {
    final type = args[1].toLowerCase();
    final name = args[2];
    final snake = u.toSnakeCase(name);
    final pascal = u.toPascalCase(name);
    if (type == 'screen') {
      await shm.makeShimmerForScreen(snake, pascal);
    } else {
      _printUsage();
      exit(64);
    }
  // removeshimmer command: showravkit removeshimmer screen <Name>
  } else if (command == 'removeshimmer') {
    final type = args[1].toLowerCase();
    final name = args[2];
    final snake = u.toSnakeCase(name);
    final pascal = u.toPascalCase(name);
    if (type == 'screen') {
      await shm.removeShimmerForScreen(snake, pascal);
    } else {
      _printUsage();
      exit(64);
    }
  } else if (command == 'mkinitscreen') {
    if (args.length < 2) {
      _printUsage();
      exit(64);
    }
    final raw = args[1];
    final className = args.length >= 3 ? args[2] : null;
    await init.makeInitialScreenRaw(raw, className);
  } else if (command == 'rminitscreen') {
    await init.removeInitialScreen('', '');
  } else {
    _printUsage();
    exit(64);
  }
}

void _printUsage() {
  stdout.writeln('Usage:');
  stdout.writeln('  showravkit create screen <Name>');
  stdout.writeln('  showravkit create screen <RoleName> <ScreenName>');
  stdout.writeln('  showravkit create screen <ScreenName> in <RoleName>');
  stdout.writeln('  showravkit create screen <ScreenName> in <PathExpr>');
  stdout.writeln('  showravkit create repository <Name>');
  stdout.writeln('  showravkit create widget <Name>');
  stdout.writeln('  showravkit create arc Base');
  stdout.writeln('  showravkit remove screen <Name> [-y|--yes]');
  stdout.writeln('  showravkit remove screen <RoleName> <ScreenName> [-y|--yes]');
  stdout.writeln('  showravkit remove screen <ScreenName> in <RoleName> [-y|--yes]');
  stdout.writeln('  showravkit remove bottombar [Name]');
  stdout.writeln('  showravkit show bottombar [Name]');
  stdout.writeln('  showravkit makeshimmer screen <Name>');
  stdout.writeln('  showravkit removeshimmer screen <Name>');
  stdout.writeln('  showravkit mkinitscreen <NameOrPath>');
  stdout.writeln('  showravkit rminitscreen [Name]');
  stdout.writeln('Examples:');
  stdout.writeln('  showravkit create screen Home');
  stdout.writeln('  showravkit create screen Admin Profile');
  stdout.writeln('  showravkit create screen Profile in Admin');
  stdout.writeln('  showravkit create arc Base');
  stdout.writeln('    creates base arc and assets/');
  stdout.writeln('  showravkit remove screen Home');
  stdout.writeln('  showravkit remove screen Admin Profile');
  stdout.writeln('  showravkit remove screen Profile in Admin');
  stdout.writeln('  showravkit remove bottombar');
  stdout.writeln('  showravkit show bottombar');
  stdout.writeln('  showravkit makeshimmer screen Profile');
  stdout.writeln('  showravkit removeshimmer screen Profile');
  stdout.writeln('  showravkit mkinitscreen Home');
  stdout.writeln('  showravkit mkinitscreen lib/screens/home/home_screen.dart');
  stdout.writeln('  showravkit rminitscreen');
}

Future<void> _createScreen(String pkg, String snake, String pascal) async {
  final featureDir = _join(['lib', 'features', snake]);
  final controllerDir = _join([featureDir, 'controller']);
  final modelDir = _join([featureDir, 'model']);
  final repositoryDir = _join([featureDir, 'repository']);
  final viewDir = _join([featureDir, 'view']);
  final widgetsDir = _join([viewDir, 'widgets']);
  await Directory(controllerDir).create(recursive: true);
  await Directory(modelDir).create(recursive: true);
  await Directory(repositoryDir).create(recursive: true);
  await Directory(widgetsDir).create(recursive: true);
  final screenFile = _join([viewDir, '${snake}_screen.dart']);
  final controllerFile = _join([controllerDir, '${snake}_controller.dart']);
  final modelFile = _join([modelDir, '${snake}_model.dart']);
  final repositoryFile = _join([repositoryDir, '${snake}_repository.dart']);
  final widgetsFile = _join([widgetsDir, '${snake}_widgets.dart']);
  await _writeIfMissing(modelFile, _modelContent(pascal));
  await _writeIfMissing(repositoryFile, _repositoryContent(pascal));
  await _writeIfMissing(controllerFile, _controllerContent(pkg, snake, pascal));
  await _writeIfMissing(screenFile, _screenContent(pascal));
  await _writeIfMissing(widgetsFile, _widgetsContent(pascal));
  stdout.writeln('Created feature scaffold: lib/features/$snake/');
  stdout.writeln('- $modelFile');
  stdout.writeln('- $repositoryFile');
  stdout.writeln('- $controllerFile');
  stdout.writeln('- $screenFile');
  stdout.writeln('- $widgetsFile');
}

Future<void> _createRepository(String pkg, String snake, String pascal) async {
  final repositoryDir = _join(['lib', 'features', snake, 'repository']);
  await Directory(repositoryDir).create(recursive: true);
  final repositoryFile = _join([repositoryDir, '${snake}_repository.dart']);
  await _writeIfMissing(repositoryFile, _repositoryContent(pascal));
  stdout.writeln('Created: $repositoryFile');
}

Future<void> _createWidgets(String pkg, String snake, String pascal) async {
  final widgetsDir = _join(['lib', 'features', snake, 'view', 'widgets']);
  await Directory(widgetsDir).create(recursive: true);
  final widgetsFile = _join([widgetsDir, '${snake}_widgets.dart']);
  await _writeIfMissing(widgetsFile, _widgetsContent(pascal));
  stdout.writeln('Created: $widgetsFile');
}

Future<void> _writeIfMissing(String path, String content) async {
  final file = File(path);
  if (await file.exists()) {
    stdout.writeln('Skipped (exists): $path');
    return;
  }
  await file.writeAsString(content);
  stdout.writeln('Created: $path');
}

String _join(List<String> parts) {
  return parts.join(Platform.pathSeparator);
}

String _toSnakeCase(String input) {
  final cleaned = input.replaceAll(RegExp(r'[^A-Za-z0-9]+'), ' ');
  final words = cleaned
      .trim()
      .split(RegExp(r'\s+'))
      .expand((w) => _splitCamel(w))
      .map((w) => w.toLowerCase())
      .toList();
  return words.join('_');
}

Iterable<String> _splitCamel(String w) {
  final b = StringBuffer();
  final res = <String>[];
  for (var i = 0; i < w.length; i++) {
    final c = w[i];
    final isUpper = c.toUpperCase() == c && c.toLowerCase() != c;
    if (i > 0 && isUpper) {
      res.add(b.toString());
      b.clear();
    }
    b.write(c);
  }
  if (b.isNotEmpty) res.add(b.toString());
  return res;
}

String _toPascalCase(String input) {
  final cleaned = input.replaceAll(RegExp(r'[^A-Za-z0-9]+'), ' ');
  final words = cleaned.trim().split(RegExp(r'\s+')).expand(_splitCamel).toList();
  return words.map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join();
}

String _readPackageName() {
  try {
    final file = File('pubspec.yaml');
    if (!file.existsSync()) return 'showravkit';
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      final l = line.trim();
      if (l.startsWith('name:')) {
        final name = l.substring(5).trim();
        return name.isEmpty ? 'showravkit' : name;
      }
    }
    return 'showravkit';
  } catch (_) {
    return 'showravkit';
  }
}

String _modelContent(String pascal) {
  return 'class ${pascal}Model {}';
}

String _repositoryContent(String pascal) {
  return '''
abstract class ${pascal}Repository {
  Future<void> init();
}

class ${pascal}RepositoryImpl implements ${pascal}Repository {
  @override
  Future<void> init() async {}
}
''';
}

String _controllerContent(String pkg, String snake, String pascal) {
  return '''
import 'package:flutter/foundation.dart';
import 'package:$pkg/features/$snake/model/${snake}_model.dart';
import 'package:$pkg/features/$snake/repository/${snake}_repository.dart';

class ${pascal}Controller extends ChangeNotifier {
  final ${pascal}Repository repo;
  ${pascal}Model state = ${pascal}Model();
  ${pascal}Controller(this.repo);
  Future<void> load() async {
    notifyListeners();
  }
}

''';
}

String _screenContent(String pascal) {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${pascal}Screen extends StatelessWidget {
  const ${pascal}Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$pascal')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$pascal Screen', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
''';
}

String _widgetsContent(String pascal) {
  return '''
import 'package:flutter/widgets.dart';

class ${pascal}Placeholder extends StatelessWidget {
  const ${pascal}Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
''';
}

Future<void> _removeScreen(String snake, String pascal) async {
  final featureDir = _join(['lib', 'features', snake]);
  final dir = Directory(featureDir);
  final pluralDir = Directory(_join(['lib', 'features', '${snake}s']));
  Directory? existsDir;
  if (dir.existsSync()) {
    existsDir = dir;
  } else if (pluralDir.existsSync()) {
    existsDir = pluralDir;
    stdout.writeln('Using plural feature: ${snake}s');
  }
  if (existsDir == null) {
    stdout.writeln('Feature not found: $featureDir');
    await _cleanupRouterForScreen(snake, pascal);
    await _cleanupBottomNavForScreen(pascal);
    await _cleanupScaffoldForScreen(snake);
    return;
  }
  final items = await existsDir.list(recursive: true).toList();
  stdout.writeln('About to delete ${items.length} items under ${existsDir.path}');
  stdout.write('Type Y to confirm: ');
  final input = stdin.readLineSync();
  final ok = input != null && (input.toLowerCase() == 'y' || input.toLowerCase() == 'yes');
  if (!ok) {
    stdout.writeln('Aborted');
    return;
  }
  await existsDir.delete(recursive: true);
  stdout.writeln('Deleted feature: ${existsDir.path}');
  await _cleanupRouterForScreen(snake, pascal);
  await _cleanupBottomNavForScreen(pascal);
  await _cleanupScaffoldForScreen(snake);
}

Future<void> _showBottomBarForScreen(String snake, String pascal) async {
  final routerPath = _join(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) {
    stdout.writeln('Router not found: $routerPath');
    return;
  }
  var content = await file.readAsString();
  var featureSnake = snake;
  var screenPascal = pascal;
  final featureDir = Directory(_join(['lib', 'features', featureSnake]));
  if (!featureDir.existsSync() && snake.endsWith('s')) {
    final singular = snake.substring(0, snake.length - 1);
    final singularDir = Directory(_join(['lib', 'features', singular]));
    if (singularDir.existsSync()) {
      featureSnake = singular;
      screenPascal = _toPascalCase(singular);
      stdout.writeln('Using singular feature: $featureSnake');
    }
  }
  final screenPath = _join(['lib', 'features', featureSnake, 'view', '${featureSnake}_screen.dart']);
  if (!File(screenPath).existsSync()) {
    stdout.writeln('Screen file not found: $screenPath');
    stdout.writeln('Create the screen first: showravkit create screen ${screenPascal}');
    return;
  }
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
  final routeMarker = "path: '/$snake'";
  if (content.contains(routeMarker)) {
    stdout.writeln('Route already exists: /$snake');
  } else {
    final profileMarker = "path: '/profile'";
    final profileIndex = content.indexOf(profileMarker);
    String routeBlock = """

        GoRoute(
          path: '/$snake',
          builder: (context, state) => const ${screenPascal}Screen(),
        ),""";
    if (profileIndex != -1) {
      final closeIndex = content.indexOf('        ),', profileIndex);
      if (closeIndex != -1) {
        final insertPos = closeIndex + '        ),'.length;
        content = content.substring(0, insertPos) + routeBlock + content.substring(insertPos);
        stdout.writeln('Inserted /$snake route under ShellRoute');
      } else {
        final routesCloseIndex = content.indexOf('      ],');
        if (routesCloseIndex != -1) {
          content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
          stdout.writeln('Appended /$snake route under ShellRoute');
        }
      }
    } else {
      final routesCloseIndex = content.indexOf('      ],');
      if (routesCloseIndex != -1) {
        content = content.substring(0, routesCloseIndex) + routeBlock + content.substring(routesCloseIndex);
        stdout.writeln('Appended /$snake route under ShellRoute');
      } else {
        stdout.writeln('Could not locate ShellRoute routes list');
      }
    }
  }
  await file.writeAsString(content);
  stdout.writeln('Bottom bar is shown for /$snake via ShellRoute.');

  final navPath = _join(['lib', 'shared', 'components', 'bottom_nav_bar.dart']);
  final navFile = File(navPath);
  if (navFile.existsSync()) {
    var nav = await navFile.readAsString();
    final hasLabel = nav.contains("label: '$pascal'") || nav.contains("label: '${screenPascal}'");
    if (!hasLabel) {
      final marker = 'destinations: const [';
      final idx = nav.indexOf(marker);
      if (idx != -1) {
        final insertPos = nav.indexOf('\n', idx) + 1;
        final destination = """        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: '$pascal',
        ),
""";
        nav = nav.substring(0, insertPos) + destination + nav.substring(insertPos);
        await navFile.writeAsString(nav);
        stdout.writeln('Added bottom nav destination: $pascal');
      }
    } else {
      stdout.writeln('Bottom nav destination already present: $pascal');
    }
  } else {
    stdout.writeln('Bottom nav component not found: $navPath');
  }

  final scaffoldPath = _join(['lib', 'app', 'app_scaffold.dart']);
  final scaffoldFile = File(scaffoldPath);
  if (scaffoldFile.existsSync()) {
    var scaffold = await scaffoldFile.readAsString();
    if (!scaffold.contains("location.startsWith('/$snake')")) {
      scaffold = scaffold.replaceFirst(
        'int _indexFromLocation(String location) {',
        "int _indexFromLocation(String location) {\n    if (location.startsWith('/$snake')) return 2;",
      );
      if (!scaffold.contains("context.go('/$snake')")) {
        scaffold = scaffold.replaceFirst(
          "  void _onTap(BuildContext context, int index) {",
          "  void _onTap(BuildContext context, int index) {\n    if (index == 2) { context.go('/$snake'); return; }",
        );
      }
      await scaffoldFile.writeAsString(scaffold);
      stdout.writeln('Updated scaffold mapping for /$snake');
    } else {
      stdout.writeln('Scaffold mapping already includes /$snake');
    }
  } else {
    stdout.writeln('App scaffold not found: $scaffoldPath');
  }
}

Future<void> _cleanupRouterForScreen(String snake, String pascal) async {
  final routerPath = _join(['lib', 'app', 'router.dart']);
  final file = File(routerPath);
  if (!file.existsSync()) return;
  var content = await file.readAsString();
  final candidates = <String>[snake, '${snake}s'];
  for (final c in candidates) {
    final importLine = "import '../features/$c/view/${c}_screen.dart';";
    if (content.contains(importLine)) {
      content = content.replaceAll(importLine, '');
      stdout.writeln('Removed import for ${_toPascalCase(c)}Screen');
    }
    final routeRegex = RegExp(r"[\s]*GoRoute\(\s*path:\s*'/" + RegExp.escape(c) + r"'\s*,[\s\S]*?        \),");
    content = content.replaceAll(routeRegex, '');
  }
  await file.writeAsString(content);
  stdout.writeln('Router cleaned for $snake');
}

Future<void> _cleanupBottomNavForScreen(String pascal) async {
  final navPath = _join(['lib', 'shared', 'components', 'bottom_nav_bar.dart']);
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
  final scaffoldPath = _join(['lib', 'app', 'app_scaffold.dart']);
  final scaffoldFile = File(scaffoldPath);
  if (!scaffoldFile.existsSync()) return;
  var s = await scaffoldFile.readAsString();
  s = s.replaceAll("if (location.startsWith('/$snake')) return 2;", '');
  s = s.replaceAll("context.go('/$snake');", '');
  s = s.replaceAll("context.go('/${snake}s');", '');
  await scaffoldFile.writeAsString(s);
  stdout.writeln('Scaffold cleaned for $snake');
}

Future<void> _makeShimmerForScreen(String snake, String pascal) async {
  var featureSnake = snake;
  var screenPascal = pascal;
  final featureDir = Directory(_join(['lib', 'features', featureSnake]));
  if (!featureDir.existsSync() && snake.endsWith('s')) {
    final singular = snake.substring(0, snake.length - 1);
    final singularDir = Directory(_join(['lib', 'features', singular]));
    if (singularDir.existsSync()) {
      featureSnake = singular;
      screenPascal = _toPascalCase(singular);
      stdout.writeln('Using singular feature: $featureSnake');
    }
  }
  final screenPath = _join(['lib', 'features', featureSnake, 'view', '${featureSnake}_screen.dart']);
  final screenFile = File(screenPath);
  if (!screenFile.existsSync()) {
    stdout.writeln('Screen file not found: $screenPath');
    stdout.writeln('Create the screen first: showravkit create screen $screenPascal');
    return;
  }
  final widgetsDir = _join(['lib', 'features', featureSnake, 'view', 'widgets']);
  await Directory(widgetsDir).create(recursive: true);
  final shimmerPath = _join([widgetsDir, '${featureSnake}_shimmer.dart']);
  final screenContent = await screenFile.readAsString();
  final type = _detectSkeletonType(screenContent);
  final shimmerContent = _shimmerContent(screenPascal, type);
  final shimmerFile = File(shimmerPath);
  if (shimmerFile.existsSync()) {
    stdout.writeln('Skipped (exists): $shimmerPath');
  } else {
    await shimmerFile.writeAsString(shimmerContent);
    stdout.writeln('Created: $shimmerPath');
  }
  var updatedScreen = screenContent;
  final shimmerImport = "import 'widgets/${featureSnake}_shimmer.dart';";
  if (!updatedScreen.contains(shimmerImport)) {
    final lines = updatedScreen.split('\n');
    var lastImportIndex = -1;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].trim().startsWith('import ')) lastImportIndex = i;
    }
    if (lastImportIndex != -1) {
      lines.insert(lastImportIndex + 1, shimmerImport);
      updatedScreen = lines.join('\n');
      stdout.writeln('Added shimmer import to screen');
    }
  }
  updatedScreen = updatedScreen.replaceAll(
      RegExp(r'const\s+Center\(\s*child:\s*CircularProgressIndicator\(\)\s*\)'),
      '${screenPascal}Shimmer()');
  updatedScreen = updatedScreen.replaceAll(
      RegExp(r'Center\(\s*child:\s*CircularProgressIndicator\(\)\s*\)'),
      '${screenPascal}Shimmer()');
  updatedScreen = updatedScreen.replaceAll(
      RegExp(r'const\s+Center\(\s*child:\s*LoadingIndicator\([^)]*\)\s*\)'),
      '${screenPascal}Shimmer()');
  updatedScreen = updatedScreen.replaceAll(
      RegExp(r'Center\(\s*child:\s*LoadingIndicator\([^)]*\)\s*\)'),
      '${screenPascal}Shimmer()');
  updatedScreen = updatedScreen.replaceAll(RegExp(r'CircularProgressIndicator\(\)'), '${screenPascal}Shimmer()');
  updatedScreen = updatedScreen.replaceAll(RegExp(r'LoadingIndicator\([^)]*\)'), '${screenPascal}Shimmer()');
  if (updatedScreen != screenContent) {
    await screenFile.writeAsString(updatedScreen);
    stdout.writeln('Replaced loading indicator with shimmer in screen');
  } else {
    stdout.writeln('No loading indicator found to replace in screen');
  }
}

String _detectSkeletonType(String content) {
  if (content.contains('ListView.builder') || content.contains('ListView.separated')) {
    return 'list';
  }
  if (content.contains('GridView.builder') || content.contains('GridView.count') || content.contains('GridView(')) {
    return 'grid';
  }
  return 'page';
}

String _shimmerContent(String pascal, String type) {
  final header = '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _baseColor = Color(0xFFE0E0E0);
const _highlightColor = Color(0xFFF5F5F5);

final _shimmerProgressProvider = StreamProvider<double>((ref) {
  final controller = StreamController<double>();
  double t = 0.0;
  final timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
    t += 0.02;
    if (t > 1.0) t -= 1.0;
    controller.add(t);
  });
  ref.onDispose(() {
    timer.cancel();
    controller.close();
  });
  return controller.stream;
});

Widget _rect({double height = 12, double width = double.infinity, BorderRadius? radius}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(color: _baseColor, borderRadius: radius ?? BorderRadius.circular(8)),
  );
}

Widget _shimmerMask(double progress, Widget child) {
  final begin = Alignment(-1.0 + 2.0 * progress, 0.0);
  final end = Alignment(1.0 + 2.0 * progress, 0.0);
  return ShaderMask(
    shaderCallback: (rect) {
      return LinearGradient(
        colors: const [_baseColor, _highlightColor, _baseColor],
        stops: const [0.1, 0.3, 0.4],
        begin: begin,
        end: end,
      ).createShader(rect);
    },
    blendMode: BlendMode.srcATop,
    child: child,
  );
}

class ${pascal}Shimmer extends ConsumerWidget {
  const ${pascal}Shimmer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(_shimmerProgressProvider).maybeWhen(data: (v) => v, orElse: () => 0.0);
    return ${type == 'list' ? '_listSkeleton(progress)' : type == 'grid' ? '_gridSkeleton(progress)' : '_pageSkeleton(progress)'};
  }
}
''';

  final listSkeleton = '''
Widget _listSkeleton(double progress) {
  return ListView.separated(
    padding: const EdgeInsets.all(16),
    itemBuilder: (context, index) {
      return _shimmerMask(
        progress,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 48, width: 48, decoration: BoxDecoration(color: _baseColor, borderRadius: BorderRadius.circular(24))),
            const SizedBox(width: 12),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rect(height: 14),
                  const SizedBox(height: 8),
                  _rect(height: 14, width: 180),
                ],
              ),
            ),
          ],
        ),
      );
    },
    separatorBuilder: (_, __) => const SizedBox(height: 16),
    itemCount: 8,
  );
}
''';

  final gridSkeleton = '''
Widget _gridSkeleton(double progress) {
  return GridView.builder(
    padding: const EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
    itemCount: 8,
    itemBuilder: (context, index) {
      return _shimmerMask(
        progress,
        Container(
          decoration: BoxDecoration(color: _baseColor, borderRadius: BorderRadius.circular(12)),
        ),
      );
    },
  );
}
''';

  final pageSkeleton = '''
Widget _pageSkeleton(double progress) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: _shimmerMask(
      progress,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rect(height: 20, width: 200),
          const SizedBox(height: 16),
          _rect(height: 14),
          const SizedBox(height: 12),
          _rect(height: 14),
          const SizedBox(height: 12),
          _rect(height: 14, width: 240),
          const SizedBox(height: 12),
          _rect(height: 14, width: 180),
        ],
      ),
    ),
  );
}
''';
  final body = type == 'list' ? listSkeleton : type == 'grid' ? gridSkeleton : pageSkeleton;
  return header + body;
}

Future<void> _removeShimmerForScreen(String snake, String pascal) async {
  var featureSnake = snake;
  var screenPascal = pascal;
  final featureDir = Directory(_join(['lib', 'features', featureSnake]));
  if (!featureDir.existsSync() && snake.endsWith('s')) {
    final singular = snake.substring(0, snake.length - 1);
    final singularDir = Directory(_join(['lib', 'features', singular]));
    if (singularDir.existsSync()) {
      featureSnake = singular;
      screenPascal = _toPascalCase(singular);
      stdout.writeln('Using singular feature: $featureSnake');
    }
  }
  final shimmerPath = _join(['lib', 'features', featureSnake, 'view', 'widgets', '${featureSnake}_shimmer.dart']);
  final shimmerFile = File(shimmerPath);
  if (shimmerFile.existsSync()) {
    await shimmerFile.delete();
    stdout.writeln('Deleted: $shimmerPath');
  } else {
    stdout.writeln('Shimmer file not found: $shimmerPath');
  }

  final screenPath = _join(['lib', 'features', featureSnake, 'view', '${featureSnake}_screen.dart']);
  final screenFile = File(screenPath);
  if (!screenFile.existsSync()) {
    stdout.writeln('Screen file not found: $screenPath');
    return;
  }
  var content = await screenFile.readAsString();
  final shimmerImport = "import 'widgets/${featureSnake}_shimmer.dart';";
  if (content.contains(shimmerImport)) {
    content = content.replaceAll(shimmerImport, '');
    stdout.writeln('Removed shimmer import from screen');
  }
  final pkg = _readPackageName();
  final loadingImport = "import 'package:$pkg/shared/widgets/loading_indicator.dart';";
  if (!content.contains(loadingImport)) {
    final lines = content.split('\n');
    var lastImportIndex = -1;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].trim().startsWith('import ')) lastImportIndex = i;
    }
    if (lastImportIndex != -1) {
      lines.insert(lastImportIndex + 1, loadingImport);
      content = lines.join('\n');
      stdout.writeln('Added loading indicator import to screen');
    }
  }
  final shimmerCallRegex = RegExp(r'(const\s+)?' + RegExp.escape(screenPascal) + r'Shimmer\(\)');
  if (shimmerCallRegex.hasMatch(content)) {
    content = content.replaceAll(shimmerCallRegex, 'const Center(child: LoadingIndicator())');
    stdout.writeln('Replaced shimmer with loading indicator in screen');
  } else {
    stdout.writeln('No shimmer usage found in screen');
  }
  await screenFile.writeAsString(content);
}
