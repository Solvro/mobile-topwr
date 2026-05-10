import "dart:convert";
import "dart:io";

void main() {
  final widgetbookDir = Directory.current;
  final libDir = Directory("${widgetbookDir.path}/lib");
  final cacheDir = Directory("${widgetbookDir.path}/build/.widgetbook");

  if (!libDir.existsSync()) {
    stderr.writeln("Widgetbook lib directory not found: ${libDir.path}");
    exitCode = 1;
    return;
  }

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
  cacheDir.createSync(recursive: true);

  final dummyPng = File("${cacheDir.path}/dummy.png");
  // 1x1 transparent PNG
  dummyPng.writeAsBytesSync(base64Decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg=="));

  int count = 0;

  for (final entity in libDir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith(".stories.g.dart")) {
      continue;
    }

    final source = entity.readAsStringSync();
    final componentName = RegExp(r"name:\s*meta\.name\s*\?\?\s*'([^']+)'").firstMatch(source)?.group(1);
    if (componentName == null) {
      continue;
    }

    final componentPath = RegExp(r"path:\s*meta\.path\s*\?\?\s*'([^']+)'").firstMatch(source)?.group(1) ?? "widgets";
    final storyNames = RegExp(r"\.\.\$generatedName\s*=\s*'([^']+)'")
        .allMatches(source)
        .map((match) => match.group(1)!)
        .toList();

    for (final storyName in storyNames.isEmpty ? const ["default"] : storyNames) {
      final name = "${componentName}_$storyName".replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      
      final record = {
        "component": {
          "name": componentName,
          "path": componentPath,
        },
        "story": {
          "name": storyName,
        },
        "scenario": {
          "name": "Default",
          "path": componentPath,
          "modes": {},
          "args": {},
        },
        "image": {
          "path": "build/.widgetbook/dummy.png",
          "hash": "dummyhash",
          "width": 1,
          "height": 1,
          "pixelRatio": 1.0,
          "size": dummyPng.lengthSync(),
        },
        "semantics": {},
      };

      File("${cacheDir.path}/$name.json").writeAsStringSync(jsonEncode(record));
      count++;
    }
  }

  if (count == 0) {
    stderr.writeln("No Widgetbook story metadata found.");
    exitCode = 1;
    return;
  }

  stdout.writeln("Generated Widgetbook V4 Cloud metadata for $count scenarios.");
}
