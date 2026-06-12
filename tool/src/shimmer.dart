import 'dart:io';
import 'utils.dart';

Future<void> makeShimmerForScreen(String snake, String pascal) async {
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
  final screenFile = File(screenPath);
  if (!screenFile.existsSync()) {
    stdout.writeln('Screen file not found: $screenPath');
    stdout.writeln('Create the screen first: showravkit create screen $screenPascal');
    return;
  }
  final widgetsDir = joinPath(['lib', 'features', featureSnake, 'view', 'widgets']);
  await Directory(widgetsDir).create(recursive: true);
  final shimmerPath = joinPath([widgetsDir, '${featureSnake}_shimmer.dart']);
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

Future<void> removeShimmerForScreen(String snake, String pascal) async {
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
  final shimmerPath = joinPath(['lib', 'features', featureSnake, 'view', 'widgets', '${featureSnake}_shimmer.dart']);
  final shimmerFile = File(shimmerPath);
  if (shimmerFile.existsSync()) {
    await shimmerFile.delete();
    stdout.writeln('Deleted: $shimmerPath');
  } else {
    stdout.writeln('Shimmer file not found: $shimmerPath');
  }
  final screenPath = joinPath(['lib', 'features', featureSnake, 'view', '${featureSnake}_screen.dart']);
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
  final pkg = readPackageName();
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

const _baseColor = Color(0xFFE0E0E0);
const _highlightColor = Color(0xFFF5F5F5);

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

class ${pascal}Shimmer extends StatefulWidget {
  const ${pascal}Shimmer({super.key});
  @override
  State<${pascal}Shimmer> createState() => _${pascal}ShimmerState();
}

class _${pascal}ShimmerState extends State<${pascal}Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final progress = _animation.value;
        return ${type == 'list' ? '_listSkeleton(progress)' : type == 'grid' ? '_gridSkeleton(progress)' : '_pageSkeleton(progress)'};
      },
    );
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
