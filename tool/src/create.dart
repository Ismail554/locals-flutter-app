import 'dart:io';
import 'utils.dart';

Future<void> createScreen(String pkg, String snake, String pascal) async {
  final featureDir = joinPath(['lib', 'features', snake]);
  final controllerDir = joinPath([featureDir, 'controller']);
  final modelDir = joinPath([featureDir, 'model']);
  final repositoryDir = joinPath([featureDir, 'repository']);
  final viewDir = joinPath([featureDir, 'view']);
  final widgetsDir = joinPath([viewDir, 'widgets']);
  await Directory(controllerDir).create(recursive: true);
  await Directory(modelDir).create(recursive: true);
  await Directory(repositoryDir).create(recursive: true);
  await Directory(widgetsDir).create(recursive: true);
  final screenFile = joinPath([viewDir, '${snake}_screen.dart']);
  final controllerFile = joinPath([controllerDir, '${snake}_controller.dart']);
  final modelFile = joinPath([modelDir, '${snake}_model.dart']);
  final repositoryFile = joinPath([repositoryDir, '${snake}_repository.dart']);
  final widgetsFile = joinPath([widgetsDir, '${snake}_widgets.dart']);
  await writeIfMissing(modelFile, _modelContent(pascal));
  await writeIfMissing(repositoryFile, _repositoryContent(pascal));
  await writeIfMissing(controllerFile, _controllerContent(pkg, snake, pascal));
  await writeIfMissing(screenFile, _screenContent(pascal));
  await writeIfMissing(widgetsFile, _widgetsContent(pascal));
  stdout.writeln('Created feature scaffold: lib${Platform.pathSeparator}features${Platform.pathSeparator}$snake${Platform.pathSeparator}');
  stdout.writeln('- $modelFile');
  stdout.writeln('- $repositoryFile');
  stdout.writeln('- $controllerFile');
  stdout.writeln('- $screenFile');
  stdout.writeln('- $widgetsFile');
}

Future<void> createScreenInDir(String pkg, String dirSnake, String screenSnake, String screenPascal) async {
  // Role directory (e.g., admin, member) and nested screen/feature directory (e.g., profile)
  final roleDir = joinPath(['lib', 'features', dirSnake]);
  final featureDir = joinPath([roleDir, screenSnake]);
  final controllerDir = joinPath([featureDir, 'controller']);
  final modelDir = joinPath([featureDir, 'model']);
  final repositoryDir = joinPath([featureDir, 'repository']);
  final viewDir = joinPath([featureDir, 'view']);
  final widgetsDir = joinPath([viewDir, 'widgets']);
  await Directory(controllerDir).create(recursive: true);
  await Directory(modelDir).create(recursive: true);
  await Directory(repositoryDir).create(recursive: true);
  await Directory(widgetsDir).create(recursive: true);
  final screenFile = joinPath([viewDir, '${screenSnake}_screen.dart']);
  final controllerFile = joinPath([controllerDir, '${screenSnake}_controller.dart']);
  final modelFile = joinPath([modelDir, '${screenSnake}_model.dart']);
  final repositoryFile = joinPath([repositoryDir, '${screenSnake}_repository.dart']);
  final widgetsFile = joinPath([widgetsDir, '${screenSnake}_widgets.dart']);
  await writeIfMissing(modelFile, _modelContent(screenPascal));
  await writeIfMissing(repositoryFile, _repositoryContent(screenPascal));
  await writeIfMissing(controllerFile, _controllerContentCustom(pkg, dirSnake, screenSnake, screenPascal));
  await writeIfMissing(screenFile, _screenContent(screenPascal));
  await writeIfMissing(widgetsFile, _widgetsContent(screenPascal));
  stdout.writeln('Created feature scaffold: lib${Platform.pathSeparator}features${Platform.pathSeparator}$dirSnake${Platform.pathSeparator}$screenSnake${Platform.pathSeparator}');
  stdout.writeln('- $modelFile');
  stdout.writeln('- $repositoryFile');
  stdout.writeln('- $controllerFile');
  stdout.writeln('- $screenFile');
  stdout.writeln('- $widgetsFile');
}

Future<void> createRepository(String pkg, String snake, String pascal) async {
  final repositoryDir = joinPath(['lib', 'features', snake, 'repository']);
  await Directory(repositoryDir).create(recursive: true);
  final repositoryFile = joinPath([repositoryDir, '${snake}_repository.dart']);
  await writeIfMissing(repositoryFile, _repositoryContent(pascal));
  stdout.writeln('Created: $repositoryFile');
}

Future<void> createWidgets(String pkg, String snake, String pascal) async {
  final widgetsDir = joinPath(['lib', 'features', snake, 'view', 'widgets']);
  await Directory(widgetsDir).create(recursive: true);
  final widgetsFile = joinPath([widgetsDir, '${snake}_widgets.dart']);
  await writeIfMissing(widgetsFile, _widgetsContent(pascal));
  stdout.writeln('Created: $widgetsFile');
}

Future<void> createScreenInPath(String pkg, List<String> dirSegmentsSnake, String screenSnake, String screenPascal) async {
  final base = ['lib', 'features', ...dirSegmentsSnake, screenSnake];
  final featureDir = joinPath(base);
  final controllerDir = joinPath([featureDir, 'controller']);
  final modelDir = joinPath([featureDir, 'model']);
  final repositoryDir = joinPath([featureDir, 'repository']);
  final viewDir = joinPath([featureDir, 'view']);
  final widgetsDir = joinPath([viewDir, 'widgets']);
  await Directory(controllerDir).create(recursive: true);
  await Directory(modelDir).create(recursive: true);
  await Directory(repositoryDir).create(recursive: true);
  await Directory(widgetsDir).create(recursive: true);
  final screenFile = joinPath([viewDir, '${screenSnake}_screen.dart']);
  final controllerFile = joinPath([controllerDir, '${screenSnake}_controller.dart']);
  final modelFile = joinPath([modelDir, '${screenSnake}_model.dart']);
  final repositoryFile = joinPath([repositoryDir, '${screenSnake}_repository.dart']);
  final widgetsFile = joinPath([widgetsDir, '${screenSnake}_widgets.dart']);
  await writeIfMissing(modelFile, _modelContent(screenPascal));
  await writeIfMissing(repositoryFile, _repositoryContent(screenPascal));
  await writeIfMissing(controllerFile, _controllerContentCustomPath(pkg, dirSegmentsSnake, screenSnake, screenPascal));
  await writeIfMissing(screenFile, _screenContent(screenPascal));
  await writeIfMissing(widgetsFile, _widgetsContent(screenPascal));
  stdout.writeln('Created feature scaffold: ${featureDir}${Platform.pathSeparator}');
  stdout.writeln('- $modelFile');
  stdout.writeln('- $repositoryFile');
  stdout.writeln('- $controllerFile');
  stdout.writeln('- $screenFile');
  stdout.writeln('- $widgetsFile');
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

String _controllerContentCustom(String pkg, String dirSnake, String fileSnake, String pascal) {
  return '''
import 'package:flutter/foundation.dart';
import 'package:$pkg/features/$dirSnake/$fileSnake/model/${fileSnake}_model.dart';
import 'package:$pkg/features/$dirSnake/$fileSnake/repository/${fileSnake}_repository.dart';

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

String _controllerContentCustomPath(String pkg, List<String> dirSegmentsSnake, String fileSnake, String pascal) {
  final rel = dirSegmentsSnake.join('/');
  return '''
import 'package:flutter/foundation.dart';
import 'package:$pkg/features/$rel/$fileSnake/model/${fileSnake}_model.dart';
import 'package:$pkg/features/$rel/$fileSnake/repository/${fileSnake}_repository.dart';

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

Future<void> createArc() async {
  final pkg = readPackageName();
  final coreDir = joinPath(['lib', 'core']);
  final startupDir = joinPath([coreDir, 'startup']);
  final featuresDir = joinPath(['lib', 'features']);
  final sharedComponentsDir = joinPath(['lib', 'shared', 'components']);
  final sharedWidgetsDir = joinPath(['lib', 'shared', 'widgets']);
  final appDir = joinPath(['lib', 'app']);
  final assetsDir = 'assets';
  await Directory(coreDir).create(recursive: true);
  await Directory(startupDir).create(recursive: true);
  await Directory(featuresDir).create(recursive: true);
  await Directory(sharedComponentsDir).create(recursive: true);
  await Directory(sharedWidgetsDir).create(recursive: true);
  await Directory(appDir).create(recursive: true);
  await Directory(assetsDir).create(recursive: true);

  final coreFile = joinPath([coreDir, 'core.dart']);
  final startupFile = joinPath([startupDir, 'startup.dart']);
  final bottomNavFile = joinPath([sharedComponentsDir, 'bottom_nav_bar.dart']);
  final routerFile = joinPath([appDir, 'router.dart']);
  final scaffoldFile = joinPath([appDir, 'app_scaffold.dart']);
  final appFile = joinPath([appDir, 'app.dart']);
  final mainFile = 'lib${Platform.pathSeparator}main.dart';

  await writeIfMissing(coreFile, 'library core;');
  await writeIfMissing(startupFile, _bootstrapContent(pkg));
  await writeIfMissing(bottomNavFile, _bottomNavContent());
  await writeIfMissing(routerFile, _routerContent());
  await writeIfMissing(scaffoldFile, _appScaffoldContent());
  await writeIfMissing(appFile, _appContent());
  await _writeMain(pkg, mainFile);

  await ensureDependencies();
  await _ensureAssetsEntry();
  stdout.writeln('Created base MVC architecture: core, features, shared, app.');
}

String _bottomNavContent() {
  return '''
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const BottomNavBar({super.key, required this.selectedIndex, required this.onSelected});
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
''';
}

String _routerContent() {
  return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_scaffold.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const Scaffold(body: Center(child: Text('Profile'))),
        ),
      ],
    ),
  ],
);
''';
}

String _appScaffoldContent() {
  return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/components/bottom_nav_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexFromLocation(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: index,
        onSelected: (i) => _onTap(context, i),
      ),
    );
  }
}

int _indexFromLocation(String location) {
  return 0;
}

void _onTap(BuildContext context, int index) {
}
''';
}

String _appContent() {
  return '''
import 'package:flutter/material.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CashLog',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
''';
}

String _bootstrapContent(String pkg) {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app.dart';

void startFlutterApp() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}
''';
}

Future<void> _writeMain(String pkg, String path) async {
  final file = File(path);
  final content = '''
import 'package:$pkg/core/startup/startup.dart';

void main() {
  startFlutterApp();
}
''';
  await file.writeAsString(content);
  stdout.writeln('Updated: $path');
}

Future<void> ensureDependencies({bool alwaysPubGet = false}) async {
  await _ensureDependencies(alwaysPubGet: alwaysPubGet);
}

Future<void> _ensureDependencies({bool alwaysPubGet = false}) async {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return;
  var text = await pubspec.readAsString();
  var lines = text.split('\n');
  bool changed = false;
  lines = lines.where((l) => !RegExp(r'^\$0\b').hasMatch(l)).toList();
  int depsIdx = lines.indexWhere((l) => l.trim() == 'dependencies:');
  if (depsIdx == -1) {
    int insertAt = lines.indexWhere((l) => l.trim() == 'dev_dependencies:');
    if (insertAt == -1) insertAt = lines.length;
    lines.insert(insertAt, '');
    lines.insert(insertAt + 1, 'dependencies:');
    lines.insert(insertAt + 2, '  flutter:');
    lines.insert(insertAt + 3, '    sdk: flutter');
    changed = true;
    depsIdx = insertAt + 1;
  }
  int depsEnd = depsIdx + 1;
  while (depsEnd < lines.length && (lines[depsEnd].isEmpty || lines[depsEnd].startsWith('  '))) {
    depsEnd++;
  }
  bool hasFlutterSdk = false;
  for (var i = depsIdx + 1; i < depsEnd; i++) {
    if (lines[i].trim() == 'flutter:' && i + 1 < depsEnd && lines[i + 1].trim() == 'sdk: flutter') {
      hasFlutterSdk = true;
      break;
    }
  }
  if (!hasFlutterSdk) {
    lines.insert(depsIdx + 1, '  flutter:');
    lines.insert(depsIdx + 2, '    sdk: flutter');
    depsEnd += 2;
    changed = true;
  }
  bool needsGoRouter = await _projectUsesImport("package:go_router/go_router.dart");
  bool needsScreenUtil = await _projectUsesImport("package:flutter_screenutil/flutter_screenutil.dart");
  bool hasGoRouter = lines.sublist(depsIdx + 1, depsEnd).any((l) => l.trim().startsWith('go_router:'));
  bool hasScreenUtil = lines.sublist(depsIdx + 1, depsEnd).any((l) => l.trim().startsWith('flutter_screenutil:'));
  if (needsGoRouter && !hasGoRouter) {
    lines.insert(depsEnd, '  go_router: ^14.1.0');
    depsEnd++;
    changed = true;
  }
  if (needsScreenUtil && !hasScreenUtil) {
    lines.insert(depsEnd, '  flutter_screenutil: ^5.9.3');
    depsEnd++;
    changed = true;
  }
  if (changed) {
    await pubspec.writeAsString(lines.join('\n'));
    stdout.writeln('Updated pubspec dependencies');
  }
  if (changed || alwaysPubGet) {
    try {
      final result = await Process.run('flutter', ['pub', 'get']);
      stdout.writeln(result.stdout);
      stderr.write(result.stderr);
    } catch (e) {
      stderr.writeln('Failed to run flutter pub get: $e');
    }
  } else {
    stdout.writeln('Dependencies already present in pubspec');
  }
}

Future<bool> _projectUsesImport(String importPath) async {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) return false;
  try {
    await for (final entity in libDir.list(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        try {
          final txt = await entity.readAsString();
          if (txt.contains("import '$importPath'") || txt.contains('import "$importPath"')) {
            return true;
          }
        } catch (_) {}
      }
    }
  } catch (_) {}
  return false;
}

Future<void> _ensureAssetsEntry() async {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return;
  final content = await pubspec.readAsString();
  if (RegExp(r'(^|\n)\s*assets:\s*\n\s*-\s*assets/', multiLine: true).hasMatch(content)) {
    return;
  }
  final lines = content.split('\n');
  int flutterIdx = -1;
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.startsWith('flutter:')) {
      flutterIdx = i;
      break;
    }
  }
  if (flutterIdx == -1) return;
  int endIdx = lines.length;
  for (var i = flutterIdx + 1; i < lines.length; i++) {
    final l = lines[i];
    if (l.isEmpty) continue;
    if (!l.startsWith('  ')) {
      endIdx = i;
      break;
    }
  }
  bool hasAssets = false;
  for (var i = flutterIdx + 1; i < endIdx; i++) {
    if (lines[i].trim().startsWith('assets:')) {
      hasAssets = true;
      break;
    }
  }
  if (hasAssets) return;
  int insertPos = flutterIdx + 1;
  for (var i = flutterIdx + 1; i < endIdx; i++) {
    if (lines[i].contains('uses-material-design')) {
      insertPos = i + 1;
      break;
    }
  }
  lines.insert(insertPos, '  assets:');
  lines.insert(insertPos + 1, '    - assets/');
  await pubspec.writeAsString(lines.join('\n'));
  stdout.writeln('Added assets/ to pubspec under flutter -> assets');
}
