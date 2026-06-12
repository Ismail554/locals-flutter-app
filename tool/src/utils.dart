import 'dart:io';

String joinPath(List<String> parts) {
  return parts.join(Platform.pathSeparator);
}

Future<void> writeIfMissing(String path, String content) async {
  final file = File(path);
  if (await file.exists()) {
    stdout.writeln('Skipped (exists): $path');
    return;
  }
  await file.writeAsString(content);
  stdout.writeln('Created: $path');
}

String toSnakeCase(String input) {
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

String toPascalCase(String input) {
  final cleaned = input.replaceAll(RegExp(r'[^A-Za-z0-9]+'), ' ');
  final words = cleaned.trim().split(RegExp(r'\s+')).expand(_splitCamel).toList();
  return words.map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join();
}

String readPackageName() {
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

List<String> parseDirSegments(String input) {
  var s = input.trim();
  s = s.replaceAll('\\', '/');
  s = s.replaceAll('->', '/');
  s = s.replaceAll('>', '/');
  final parts = s.split(RegExp(r'/+')).where((p) => p.trim().isNotEmpty).toList();
  var start = 0;
  if (start < parts.length && parts[start].toLowerCase() == 'lib') start++;
  if (start < parts.length && parts[start].toLowerCase() == 'features') start++;
  final segs = parts.sublist(start);
  return segs.map((e) => toSnakeCase(e)).toList();
}
