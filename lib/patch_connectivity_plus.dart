import 'dart:io';

void main() {
  final pubCacheDir =
  Directory('C:/Users/DELL/AppData/Local/Pub/Cache/hosted/pub.dev/');

  if (!pubCacheDir.existsSync()) {
    print("⚠️ Pub cache directory not found: ${pubCacheDir.path}");
    return;
  }

  final plugins = [
    'connectivity_plus',
    'firebase_core',
    'image_picker_android',
    'device_info_plus',
    'deepar_flutter_plus',
  ];

  int patchedCount = 0;

  // Loop through all folders in pub cache
  final allPluginDirs = pubCacheDir
      .listSync()
      .whereType<Directory>()
      .toList();

  for (var plugin in plugins) {
    // Filter directories that start with plugin name (handles versions)
    final pluginDirs = allPluginDirs
        .where((d) => d.path.contains(RegExp(r'/'+plugin+r'[-\d.]*$', caseSensitive: false)))
        .toList();

    if (pluginDirs.isEmpty) {
      print("⚠️ Plugin not found: $plugin");
      continue;
    }

    for (var dir in pluginDirs) {
      // Recursively find all Java files
      final javaFiles = dir
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith(".java"))
          .toList();

      for (var file in javaFiles) {
        try {
          String content = file.readAsStringSync();

          // Skip files that already import android.util.Log
          if (content.contains("import android.util.Log;")) continue;

          // Skip files that already import io.flutter.Log
          if (content.contains("import io.flutter.Log;")) continue;

          // Insert android.util.Log import after android.content.Context import if exists
          if (content.contains("import android.content.Context;")) {
            content = content.replaceFirst(
              "import android.content.Context;",
              "import android.content.Context;\nimport android.util.Log;",
            );
          } else {
            // fallback: insert after package declaration
            content = content.replaceFirstMapped(
                RegExp(r'package\s+.*;'),
                    (match) => "${match.group(0)}\nimport android.util.Log;");
          }

          file.writeAsStringSync(content);
          patchedCount++;
          print("✅ Patched: ${file.path}");
        } catch (e) {
          print("⚠️ Failed to patch ${file.path}: $e");
        }
      }
    }
  }

  print("\n🎯 Done! Patched $patchedCount file(s).");
}
